//
//  DiscountView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct DiscountView: View {
    @State private var searchString: String = ""
    @State private var isSearchBarVisible: Bool = false
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ButtonBackUIView()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    ButtonSearchUIView(isSearchOpen: $isSearchBarVisible)
                }
            }
        }
        .refreshable {
            print("Refresh Discount")
        }
        .background(Color.mainBackgroundColor)
        .searchable(text: $searchString, isPresented: $isSearchBarVisible, prompt: Text("Tìm kiếm"))
    }
}

#Preview {
    NavigationStack {
        DiscountView()
    }
}
