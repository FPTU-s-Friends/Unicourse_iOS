//
//  CheckoutView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

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

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(appData.cartSelectedItems, id: \._id) { item in
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
                        }
                    }

                    DividerView(text: "Chi tiết")

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

                    DividerView(text: "Tổng số")

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
                .padding(.horizontal, 20)

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
                .padding()
            }

            Spacer()

            VStack {
                Button(action: processPayment, label: {
                    ButtonGradientUI(titleButton: "Thanh Toán")
                })
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
        .alert(isPresented: $appData.isShowingAlert) {
            Alert(
                title: Text("Error"),
                message: Text(appData.error ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
            )
        }
        .sheet(item: $paymentUrl) { identifiableUrl in
            SafariView(url: identifiableUrl.url)
        }
    }

    private func processPayment() {
        Task {
            print(appData.token)
            do {
                let items = appData.cartSelectedItems.map { item in
                    itemCreatePaymentModel(
                        name: item.title,
                        quantity: 1,
                        price: item.amount
                    )
                }
//                let totalAmount = max(appData.calculateTotalAmount() - appData.calculateTotalCoin(), 0)
                let totalAmount = 2000
                let paymentInfo = CreatePaymentLinkModel(
                    orderCode: Int.random(in: 1000 ... 9999999),
                    amount: totalAmount,
                    description: "Order payment",
                    items: items
                )
                let token = appData.token
                let response = try await appData.createPaymentLink(token: token, paymentInfo: paymentInfo)

                if let data = response.data {
                    print("Payment link created successfully: \(data.checkoutUrl)")
                    if let url = URL(string: data.checkoutUrl) {
                        paymentUrl = IdentifiableURL(url: url)
                    } else {
                        appData.error = "Invalid checkout URL"
                        appData.isShowingAlert = true
                    }
                }

            } catch {
                appData.error = error.localizedDescription
                appData.isShowingAlert = true
            }
        }
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
