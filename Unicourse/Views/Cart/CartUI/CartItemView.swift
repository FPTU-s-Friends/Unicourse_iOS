//
//  CartItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct CartItemView: View {
    @State private var isChecked: Bool = false
    @Binding var isCheckedAll: Bool
    @State private var isCheckedAllItemPerson = false
    @Binding var name: String

    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .leading) {
                    HeaderCartItemView(name: $name, isCheckedAll: $isCheckedAll, isCheckedAllItemPerson: $isCheckedAllItemPerson)

                    CartProductItem(isChecked: $isChecked, isCheckedAllItemPerson: $isCheckedAllItemPerson)
                }
                .padding()
                .background(Color.white.cornerRadius(10))
                .onChange(of: isCheckedAll) { _, _ in
                    // nếu mà bấm nút tổng check thì check hết toàn bộ khoá học
                    isChecked = isCheckedAll
                }
            }
            .padding()
        }
    }
}

#Preview {
    CartItemView(isCheckedAll: .constant(false), name: .constant("Nguyễn Trung Kiên"))
}
