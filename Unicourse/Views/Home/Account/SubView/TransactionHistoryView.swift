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

    @StateObject var viewModel = TransactionHistoryViewModel()

    var body: some View {
        ScrollView {
            VStack {
                if viewModel.isLoadingFetching {
                    ForEach(0 ..< 3) { _ in
                        HistoryTransactionItemSkeleton()
                            .transition(.opacity.combined(with: .scale))
                            .animation(.easeInOut(duration: 0.6), value: viewModel.isLoadingFetching)
                    }
                } else if viewModel.isLoadingFetching == false && viewModel.transactionHistoryList.isEmpty {
                    NotfoundView(systemName: "shippingbox.circle", message: "Không tìm thấy lịch sử giao dịch")
                        .transition(.opacity.combined(with: .slide))
                        .animation(.easeInOut(duration: 0.6), value: viewModel.transactionHistoryList.isEmpty)
                } else {
                    ForEach(viewModel.transactionHistoryList, id: \._id) { transactionItem in
                        HistoryTransactionItem(transactionHistory: transactionItem)
                            .transition(.opacity.combined(with: .blurReplace))
                            .animation(.easeInOut(duration: 0.6))
                    }
                }
            }

            .onAppear {
                if viewModel.isLoadingFirstime {
                    Task {
                        viewModel.isLoadingFetching = true
                        try await viewModel.getListTransactionHistory(token: appData.token)
                        viewModel.isLoadingFirstime = false
                        viewModel.isLoadingFetching = false
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ButtonBackUIView()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    ButtonSearchUIView(isSearchOpen: $viewModel.isSearchBarVisible)
                }
            }
        }
        .searchable(text: $viewModel.searchText, isPresented: $viewModel.isSearchBarVisible)
        .refreshable {
            Task {
                viewModel.isLoadingFetching = true
                try await viewModel.getListTransactionHistory(token: appData.token)
                viewModel.isLoadingFetching = false
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
