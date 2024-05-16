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
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .frame(width: 10, height: 18)
                            .padding(.horizontal, 15)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            isSearchBarVisible.toggle()
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .frame(width: 10, height: 18)
                            .padding(.horizontal, 15)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TransactionHistoryView()
    }
}
