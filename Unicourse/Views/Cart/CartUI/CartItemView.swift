//
//  CartItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct CartItemView: View {
    @State private var isChecked: Bool = false
    @State private var isShowMore = false
    var item: CartItem

    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .leading) {
                    HeaderCartItemView(isShowMore: $isShowMore)

                    CartProductItem(isChecked: $isChecked, item: item)

                    if isShowMore {
                        VStack {
                            Text("More detail here")
                        }
                    }
                }
                .padding()
                .background(Color.white.cornerRadius(10))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    CartItemView(item: .sampleData)
        .environmentObject(AppData())
}
