//
//  CartView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var appData: AppData
   
    var body: some View {
        VStack {
            ScrollView {
                // Course added Item
                if let cart = appData.cart, !cart.items.isEmpty {
                    ForEach(cart.items, id: \._id) { item in
                        CartItemView(item: item)
                    }

                } else {
                    NotfoundView(systemName: "shippingbox.fill", message: NSLocalizedString("notfound_cart", comment: ""))
                }
                Spacer()
            }
            .refreshable {
                Task {
                    try await appData.getUserCart(token: appData.token)
                }
            }


            CartBottomView()
        }
        .background(Color.mainBackgroundColor)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonBackUIView()
            }
        }
        .navigationBarTitle("Giỏ hàng 🛒", displayMode: .large)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        CartView()
            .environmentObject(AppData())
    }
}
