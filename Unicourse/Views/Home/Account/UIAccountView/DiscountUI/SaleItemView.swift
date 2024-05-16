//
//  saleItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 16/5/24.
//

import SwiftUI

struct SaleItemView: View {
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Image("saleIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)

                    VStack {
                        Image("Voucher")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35)

                        Text("Tiêu đề giảm giá")
                            .font(.system(size: 10, weight: .light))
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 5)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("BAEKBLAHLG")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.leading, 3)
                    HStack(spacing: 10) {
                        Text("Giảm giá 50%")
                            .font(Font.custom("Montserrat", size: 12).weight(.medium))
                            .lineSpacing(20)
                            .foregroundColor(.red)
                    }
                    .frame(width: 100, height: 25)
                    .background(Color(red: 0.95, green: 0.86, blue: 0.78))
                    .cornerRadius(40)

                    Text("Giới hạn: 1 lần sử dụng")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.leading, 5)
                }

                Spacer()
                Button(action: {}, label: {
                    Image("iconCopy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                })
            }
            .background(Color.white.cornerRadius(10))
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    SaleItemView()
}
