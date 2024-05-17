//
//  CartView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct CartView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    // Biến cục bộ để checkAll toàn bộ sản phẩm
    @State private var isCheckedAll: Bool = false

    var body: some View {
        VStack {
            // Course added Item
            ScrollView {
                CartItemView(isCheckedAll: $isCheckedAll, name: .constant("Nguyễn Trung Kiên"))
                CartItemView(isCheckedAll: $isCheckedAll, name: .constant("Trần Quang Minh"))
            }
            Spacer()

            // Bottom
            CartBottomView()
        }
        .background(Color.mainBackgroundColor)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                })
            }

            ToolbarItem(placement: .topBarTrailing) {
                ButtonCheckBox(isChecked: $isCheckedAll)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CartView()
    }
}
