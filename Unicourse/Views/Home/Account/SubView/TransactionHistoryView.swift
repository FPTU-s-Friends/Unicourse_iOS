//
//  TransactionHistoryView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct TransactionHistoryView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss: DismissAction
    @State private var isSearchBarVisible: Bool = false
    @StateObject var viewModel = TransactionHistoryViewModel()

    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.transactionHistoryList, id: \._id) { transactionItem in
                    HistoryTransactionItem(transactionHistory: transactionItem)
                }
            }
            .onAppear {
                Task {
                    try await viewModel.getListTransactionHistory(token: appData.token)
                }
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
            .environmentObject(AppData())
    }
}
