//
//  CartBottomView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct CartBottomView: View {
    var body: some View {
        // Bottom Cart
        VStack {
            VStack {
                Button(action: {}, label: {
                    HStack {
                        Image("Voucher1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .foregroundStyle(.red)

                        Text("Chọn mã giảm giá")
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(.gray)

                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15)
                    }
                    .padding(14)
                })
            }
            .background(Color.grayItem.cornerRadius(10))
            .padding(.horizontal, 20)
            .padding(.top, 10)

            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tổng giá")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(.gray)

                    HStack {
                        Text("70.000 VND")
                            .font(.system(size: 16, weight: .bold))
                            .lineSpacing(20)
                            .foregroundColor(.activeColor)
                        Text("90.000 VND")
                            .font(.system(size: 14, weight: .light))
                            .lineSpacing(20)
                            .strikethrough()
                            .foregroundStyle(.gray)
                    }
                }

                Spacer()

                NavigationLink(destination: CheckoutView()) {
                    ButtonGradientUI(titleButton: "Mua Ngay")
                        .frame(width: 160)
                }
            }
            .padding(.horizontal, 20)
        }
        .background(.white)
    }
}

#Preview {
    CartBottomView()
}
