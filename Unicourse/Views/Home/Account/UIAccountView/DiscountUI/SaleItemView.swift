//
//  saleItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 16/5/24.
//

import SwiftUI

struct SaleItemView: View {
    var textTitle: String
    var code: String

    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Image("saleIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)

                    VStack {
                        Image("Voucher")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.09)

                        Text(textTitle)
                            .font(.system(size: UIScreen.main.bounds.width * 0.025, weight: .light))
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 5)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text(code)
                        .font(.system(size: UIScreen.main.bounds.width * 0.04, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.leading, 3)
                    HStack(spacing: 10) {
                        Text("Giảm giá 10%")
                            .font(Font.custom("Montserrat", size: UIScreen.main.bounds.width * 0.03).weight(.medium))
                            .lineSpacing(20)
                            .foregroundColor(.red)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.06)
                    .background(Color(red: 0.95, green: 0.86, blue: 0.78))
                    .cornerRadius(UIScreen.main.bounds.width * 0.06)

                    Text("Giới hạn: 1 lần sử dụng")
                        .font(.system(size: UIScreen.main.bounds.width * 0.03))
                        .foregroundColor(.gray)
                        .padding(.leading, 5)
                }

                Spacer()
                Button(action: {}, label: {
                    Image("iconCopy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.08)
                        .padding(.horizontal, 10)
                })
            }
            .background(Color.white.cornerRadius(10))
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    SaleItemView(textTitle: "Tiêu đề giảm giá", code: "BAEKBLAHLG")
}
