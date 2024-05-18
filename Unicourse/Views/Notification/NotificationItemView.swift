//
//  NotificationItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 18/5/24.
//

import SwiftUI

struct NotificationItemView: View {
    var title: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18, weight: .bold))

            VStack(alignment: .leading) {
                VStack {
                    HStack {
                        Image("User")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Nguyễn Trung Kiên")
                                .font(.system(size: 16, weight: .bold))

                            Text("Đã thêm 3 chương mới vào khoá học")
                                .font(.system(size: 14, weight: .light))
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .foregroundStyle(.gray)
                        }

                        Spacer()
                        HStack {
                            Image(systemName: "clock")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16)

                            Text("12:06")
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(.gray)
                        }
                        .offset(y: -20)
                        .frame(height: 50)
                    }
                }
            }
            .padding(20)
            .background(Color.white.cornerRadius(10))

            VStack(alignment: .leading) {
                VStack {
                    HStack {
                        Image("User")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Thanh toán thành công")
                                .font(.system(size: 16, weight: .bold))

                            Text("Bạn đã thanh toán thành công, hãy bắt đầu lộ trình học MAD 101 ngay bây giờ")
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(.gray)
                        }

                        Spacer()
                        HStack {
                            Image(systemName: "clock")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16)

                            Text("09:06")
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(.gray)
                        }
                        .offset(y: -20)
                        .frame(height: 50)
                    }

                    HStack(spacing: 20) {
                        Button(action: {}, label: {
                            Text("Xem khoá học")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.black)
                                .padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 0.25)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        })
                        ButtonGradient(title: "Bắt đầu", action: {})
                    }
                    .padding(.leading, 10)
                }
            }
            .padding(20)
            .background(Color.white.cornerRadius(10))
        }
    }
}

#Preview {
    NotificationItemView()
}
