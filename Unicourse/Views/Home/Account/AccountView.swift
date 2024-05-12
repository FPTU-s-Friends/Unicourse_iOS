//
//  AccountView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom)
                .ignoresSafeArea(.container)
            VStack {
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .padding(10)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 0.1)
                            )
                    })

                    Spacer()
                    HStack {
                        VStack {
                            Button(action: {}, label: {
                                Image(systemName: "cart")
                                    .font(.system(size: 20))
                                    .padding(10)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.gray, lineWidth: 0.1)
                                    )
                            })
                        }
                        Button(action: {}, label: {
                            Image(systemName: "pencil")
                                .font(.system(size: 20))
                                .padding(10)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 0.1)
                                )
                        })
                    }
                }
                .padding(.horizontal, 20)
                
                Text("12")
                    .font(.system(size: 10))
                    .foregroundStyle(.white)
                    .padding(2)
                    .background(Color.red.cornerRadius(20))
                    .offset(x: 135, y: -50)

                VStack {
                    Image("User")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                    Text("Nguyễn Trung Kiên")
                        .font(.system(size: 16, weight: .bold))

                    HStack(spacing: 50) {
                        VStack(spacing: 15) {
                            Image(systemName: "clock")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundStyle(.blue)

                            Text("Tiến trình")
                                .font(.system(size: 12, weight: .light))
                                .foregroundStyle(.gray)

                            Text("68 Giờ")
                                .font(.system(size: 14, weight: .bold))
                        }

                        VStack(spacing: 15) {
                            Image(systemName: "rosette")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundStyle(.yellow)

                            Text("Hoàn Thành")
                                .font(.system(size: 12, weight: .light))
                                .foregroundStyle(.gray)

                            Text("84%")
                                .font(.system(size: 14, weight: .bold))
                        }

                        VStack(spacing: 15) {
                            Image(systemName: "book")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundStyle(.blue)

                            Text("Tiến trình")
                                .font(.system(size: 12, weight: .light))
                                .foregroundStyle(.gray)

                            Text("6 Khoá")
                                .font(.system(size: 14, weight: .bold))
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(20)

                    VStack {
                        HStack {
                            Image(systemName: "heart.fill")

                            Text("Yêu thích (12)")

                            Spacer()

                            Image(systemName: "arrow.right")
                        }

                        HStack {
                            Image(systemName: "clock.fill")

                            Text("Xem gần nhất")

                            Spacer()

                            Image(systemName: "arrow.right")
                        }

                        HStack {
                            Image(systemName: "heart.fill")

                            Text("Mã giảm giá")

                            Spacer()

                            Image(systemName: "arrow.right")
                        }

                        HStack {
                            Image(systemName: "heart.fill")

                            Text("Lịch sử giao dịch")

                            Spacer()

                            Image(systemName: "arrow.right")
                        }
                    }
                    .padding(.horizontal, 50)
                }
                .frame(width: 400, height: 600)
                Spacer()
            }
        }
    }
}

#Preview {
    AccountView()
}
