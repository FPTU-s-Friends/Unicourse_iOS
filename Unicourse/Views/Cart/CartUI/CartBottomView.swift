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
                            Text("\(calculateTotalAmount(), specifier: "%.0f") VND")
                                .font(.system(size: 14, weight: .bold))
                                .lineSpacing(20)
                                .foregroundColor(.activeColor)
                            Text("\(calculateTotalAmount() + 10000, specifier: "%.0f") VND")
                                .font(.system(size: 12, weight: .light))
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
                        NotfoundView(systemName: "shippingbox.circle", message: "Không có voucher nào phù hợp !")

//                        Section(header: Text("Phiếu đặc biệt")
//                            .font(.system(size: 14, weight: .medium))
//                            .foregroundStyle(.gray)
//                        ) {
//                            SaleItemView(textTitle: "Tiêu đề 1", code: "CODE123")
//                            SaleItemView(textTitle: "Tiêu đề 2", code: "CODE456")
//                        }
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

    private func calculateTotalAmount() -> Double {
        return Double(appData.cartSelectedItems.reduce(0) { $0 + $1.amount })
    }
}

#Preview {
    CartBottomView()
        .environmentObject(AppData())
}
