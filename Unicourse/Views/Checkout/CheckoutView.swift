import SwiftUI

enum PaymentMethod: CustomStringConvertible {
    case VNPay
    case VietQR

    var description: String {
        switch self {
        case .VNPay:
            return "VNPay"
        case .VietQR:
            return "VietQR"
        }
    }
}

struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}

struct CheckoutView: View {
    @EnvironmentObject var appData: AppData
    @State private var selectedPaymentMethod: PaymentMethod?
    @State private var paymentUrl: IdentifiableURL?
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertAction: (() -> Void)?
    @State private var paymentDetails: String?
    @State private var path = NavigationPath()
    @State private var orderCode = 0
    @State private var isNavigateToHomeScreen = false
    @State private var selectedTab: Tab = .course
    @State private var navigateToHome = false

    private var hasItemsInCart: Bool {
        return appData.cart?.items.isEmpty == false
    }

    private var canProceedToPayment: Bool {
        return hasItemsInCart && selectedPaymentMethod != nil
    }

    var body: some View {
        ZStack {
            NavigationStack(path: $path) {
                VStack {
                    ScrollView {
                        VStack {
                            ForEach(appData.cart?.items ?? [], id: \._id) { item in
                                CartItemViewForCheckout(item: item)
                            }

                            DividerView(text: "Chi tiết")

                            CartDetailsView(selectedPaymentMethod: $selectedPaymentMethod)

                            DividerView(text: "Tổng số")

                            CartTotalView()
                        }
                        .padding(.horizontal, 20)

                        PaymentMethodSelectionView(selectedPaymentMethod: $selectedPaymentMethod)
                            .padding()
                    }

                    Spacer()

                    VStack {
                        PaymentButton(canProceedToPayment: canProceedToPayment, processPayment: processPayment)
                            .padding(.horizontal, 20)
                    }
                    .background(Color.white)
                }
                .background(Color.mainBackgroundColor)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        ButtonBackUIView()
                    }
                }
                .navigationTitle("Thanh Toán")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarBackButtonHidden(true)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Thông Báo"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK")) {
                            showAlert = false
                            alertAction?()
                        }
                    )
                }
                .fullScreenCover(isPresented: Binding(
                    get: { paymentUrl != nil },
                    set: { show in
                        if !show {
                            paymentUrl = nil
                        }
                    }
                )) {
                    if let paymentUrl = paymentUrl {
                        SafariView(url: paymentUrl.url) {
                            Task {
                                await checkPaymentStatus()
                            }
                        }
                    }
                }

                NavigationLink(destination: CustomHomeView(activeTab: $selectedTab)
                    .navigationBarBackButtonHidden(true), isActive: $navigateToHome) {
                    EmptyView()
                }
            }

            if appData.isLoading {
                LoadingIndicatorView(isLoading: .constant(true))
            }
        }
    }

    private func processPayment() {
        Task {
            appData.isLoading = true
            do {
                let items = appData.cart?.items.map { item in
                    itemCreatePaymentModel(
                        name: item.title,
                        quantity: 1,
                        price: item.amount
                    )
                }
                let totalAmount = 2000

                let paymentInfo = CreatePaymentLinkModel(
                    orderCode: Int.random(in: 1000 ... 9999999),
                    amount: totalAmount,
                    description: "Order payment",
                    items: items ?? []
                )
                let token = appData.token
                let response = try await appData.createPaymentLink(token: token, paymentInfo: paymentInfo)

                if let data = response.data {
                    print("Payment link created successfully: \(data.checkoutUrl)")
                    if let url = URL(string: data.checkoutUrl) {
                        paymentUrl = IdentifiableURL(url: url)
                        orderCode = data.orderCode
                    } else {
                        appData.error = "Invalid checkout URL"
                        appData.isShowingAlert = true
                    }
                }

            } catch {
                appData.error = error.localizedDescription
                appData.isShowingAlert = true
            }
            appData.isLoading = false
        }
    }

    private func checkPaymentStatus() async {
        do {
            let response = try await appData.getPaymentLinkInfo(token: appData.token, orderCode: orderCode)
            if let data = response.data {
                if data.status == "PAID" {
                    alertMessage = "Thanh toán thành công !"
                    alertAction = handlePaymentSuccess
                } else if data.status == "PENDING" {
                    alertMessage = "Chưa thực hiện thanh toán..."
                    alertAction = nil
                }
                showAlert = true
            }
        } catch {
            appData.error = error.localizedDescription
            appData.isShowingAlert = true
        }
    }

    private func handlePaymentSuccess() {
        Task {
            appData.isLoading = true
            let paymentTransaction = TransactionRequestModel(userId: appData.userInfo?._id ?? "",
                                                             process_date: "\(Date.now)",
                                                             payer: payerTransaction(name: appData.userInfo?.fullName ?? "",
                                                                                     email: appData.userInfo?.email ?? "",
                                                                                     address: ""),
                                                             cart_id: appData.cart?._id ?? "",
                                                             payment_method: "\(selectedPaymentMethod?.description ?? "")",
                                                             total_old_amount: appData.calculateTotalAmount(),
                                                             total_new_amount: appData.calculateTotalAmount() - appData.calculateTotalCoin(),
                                                             voucher_id: "613c5a6691e9d57d128d9a35",
                                                             status: "success",
                                                             transaction_code: "TRX123456789")
            try await appData.createTransaction(token: appData.token, data: paymentTransaction)
            try await appData.getUserInfo(userId: appData.user?.userId ?? "", token: appData.token)
            appData.isLoading = false
            appData.cart?.items.removeAll()
            navigateToHome = true
        }
    }
}

struct CartItemViewForCheckout: View {
    let item: CartItem

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.thumbnail)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: 75)
                    .cornerRadius(10)
            } placeholder: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: 75)
                    .shimmerWithWave()
            }

            VStack(alignment: .leading) {
                Text(item.title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .font(.system(size: 12, weight: .light))

                HStack {
                    Text("\(item.amount) VND")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .foregroundColor(.activeColor)

                    Text("\(item.amount + 20000) VND")
                        .font(.system(size: 12, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .strikethrough()
                        .foregroundColor(.gray)
                }
            }

            Spacer()
        }
    }
}

struct CartDetailsView: View {
    @Binding var selectedPaymentMethod: PaymentMethod?
    @EnvironmentObject var appData: AppData

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Giá sản phẩm ước lượng: ")
                    .font(.system(size: 13, weight: .semibold))

                Text("Tổng xu đã sử dụng: ")
                    .font(.system(size: 13, weight: .semibold))

                Text("Hình thức thanh toán")
                    .font(.system(size: 13, weight: .semibold))
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 8) {
                Text("\(appData.calculateTotalAmount()) VND")
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(.gray)

                Text("\(appData.calculateTotalCoin()) VND")
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(.gray)

                if let payment = selectedPaymentMethod {
                    Text(payment.description)
                        .font(.system(size: 13, weight: .light))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.UIButtonGreen.cornerRadius(10))
                        .foregroundColor(.white)
                } else {
                    Text(NSLocalizedString("no_payment_selected", comment: ""))
                        .font(.system(size: 10, weight: .light))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.gray.cornerRadius(10))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct CartTotalView: View {
    @EnvironmentObject var appData: AppData

    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing, spacing: 8) {
                Text("Tổng giá")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.gray)

                Text("\(max(appData.calculateTotalAmount() - appData.calculateTotalCoin(), 0)) VND")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.activeColor)
            }
        }
    }
}

struct PaymentMethodSelectionView: View {
    @Binding var selectedPaymentMethod: PaymentMethod?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Chọn hình thức thanh toán")
                .font(.system(size: 16, weight: .semibold))

            VStack {
                PaymentMethodItemView(
                    isSelected: selectedPaymentMethod == .VNPay,
                    icon: "VNPAY",
                    name: "VNPAY"
                )
                .onTapGesture {
                    withAnimation {
                        selectedPaymentMethod = .VNPay
                    }
                }

                PaymentMethodItemView(
                    isSelected: selectedPaymentMethod == .VietQR,
                    icon: "VietQR",
                    name: "VIETQR"
                )
                .onTapGesture {
                    withAnimation {
                        selectedPaymentMethod = .VietQR
                    }
                }
            }
        }
    }
}

struct PaymentButton: View {
    let canProceedToPayment: Bool
    let processPayment: () -> Void

    var body: some View {
        Button(action: processPayment, label: {
            ButtonGradientUI(titleButton: "Thanh Toán")
        })
        .disabled(!canProceedToPayment)
        .opacity(canProceedToPayment ? 1 : 0.5)
    }
}

struct DividerView: View {
    let text: String

    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
            Text(text)
                .font(.system(size: 12, weight: .light))
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView()
            .environmentObject(AppData())
    }
}
