//
//  CartBottomView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct CartBottomView: View {
    @EnvironmentObject var appData: AppData
    @State private var isShowingListVoucher = false

    var body: some View {
        // Bottom Cart
        VStack {
            if let cart = appData.cart, !cart.items.isEmpty {
                VStack {
                    Button(action: {
                        withAnimation {
                            isShowingListVoucher = true
                        }
                    }, label: {
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
                            Text("\(String(describing: appData.cart?.amount ?? 0))")
                                .font(.system(size: 16, weight: .bold))
                                .lineSpacing(20)
                                .foregroundColor(.activeColor)
                            Text("\(String(describing: (appData.cart?.amount ?? 0) + 10000))")
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
        }
        .sheet(isPresented: $isShowingListVoucher, content: {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Section(header: Text("Phiếu đặc biệt")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.gray)
                        ) {
                            SaleItemView()
                            SaleItemView()
                        }

                        Section(header: Text("Phiếu đặc biệt")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.gray)
                        ) {
                            SaleItemView()
                            SaleItemView()
                            SaleItemView()
                            SaleItemView()
                            SaleItemView()
                            SaleItemView()
                        }
                    }
                    .padding()
                }
                .navigationTitle("Mã giảm giá")
                .navigationBarTitleDisplayMode(.large)
                .presentationDetents([.large])
            }

        })
        .background(.white)
    }
}

#Preview {
    CartBottomView()
}
