//
//  TransactionHistoryView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct TransactionHistoryView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @State private var isSearchBarVisible: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                HistoryTransactionItem(name: "Nguyễn Trung Kiên")

                HistoryTransactionItem(name: "Trần Quang Minh")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ButtonBackUIView()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    ButtonSearchUIView(isSearchOpen: $isSearchBarVisible)
                }
            }
        }
        .background(Color.mainBackgroundColor)
    }
}

#Preview {
    NavigationStack {
        TransactionHistoryView()
    }
}
