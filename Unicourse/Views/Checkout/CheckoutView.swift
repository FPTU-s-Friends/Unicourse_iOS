//
//  CheckoutView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

enum PaymentMethod {
    case payPal
    case VNPay
}

struct CheckoutView: View {
    @State var selectedPaymentMethod: PaymentMethod?

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Chọn hình thức thanh toán")
                        .font(.system(size: 16, weight: .semibold))

                    VStack {
                        PaymentMethodItemView(
                            isSelected: selectedPaymentMethod == .payPal,
                            icon: "PayPal",
                            name: "PayPal"
                        )
                        .onTapGesture {
                            withAnimation {
                                selectedPaymentMethod = .payPal
                            }
                        }

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

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                })
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
    }
}
