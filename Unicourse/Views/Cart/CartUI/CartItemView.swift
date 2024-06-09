//
//  CartItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct CartItemView: View {
    @State private var isChecked: Bool = false
    @State private var isCheckedAllItemPerson = false
    var item: CartItem

    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .leading) {
                    HeaderCartItemView(isCheckedAllItemPerson: $isCheckedAllItemPerson)

                    CartProductItem(isChecked: $isChecked, isCheckedAllItemPerson: $isCheckedAllItemPerson, item: item)
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
