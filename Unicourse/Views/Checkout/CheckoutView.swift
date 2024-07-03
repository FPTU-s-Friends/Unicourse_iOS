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

struct CheckoutView: View {
    @EnvironmentObject var appData: AppData
    @State var selectedPaymentMethod: PaymentMethod?

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
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: UIScreen.main.bounds.width * 0.3, height: 75)
                                    .cornerRadius(10)
                                    .shimmerWithWave()
                            }

                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                    .font(.system(size: 12, weight: .light))
                                // ---
                                HStack {
                                    Text("\(item.amount) VND")
                                        .font(.system(size: 14, weight: .bold))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                        .foregroundColor(.activeColor)
                                    // ---
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

                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                        Text("Chi tiết")
                            .font(.system(size: 12, weight: .light))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }

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
                                .foregroundStyle(.gray)

                            Text("\(appData.calculateTotalCoin()) VND")
                                .font(.system(size: 13, weight: .light))
                                .foregroundStyle(.gray)

                            if let payment = selectedPaymentMethod {
                                Text(payment.description)
                                    .font(.system(size: 13, weight: .light))
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.UIButtonGreen.cornerRadius(10))
                                    .foregroundStyle(.white)
                            } else {
                                Text(NSLocalizedString("no_payment_selected", comment: ""))
                                    .font(.system(size: 10, weight: .light))
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.gray.cornerRadius(10))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                        Text("Tổng số")
                            .font(.system(size: 12, weight: .light))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 8) {
                            Text("Tổng giá")
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(.gray)

                            Text("\(appData.calculateTotalAmount() - appData.calculateTotalCoin()) VND")
                                .font(.system(size: 16, weight: .bold))
                                .lineSpacing(20)
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
                Button(action: {}, label: {
                    ButtonGradientUI(titleButton: "Thanh Toán")
                })

                .padding(.horizontal, 20)
            }
            .background(.white)
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
    }
}

#Preview {
    NavigationStack {
        CheckoutView()
            .environmentObject(AppData())
    }
}
