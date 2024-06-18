//
//  TransactionHistoryViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 18/6/24.
//

import Foundation

class TransactionHistoryViewModel: ObservableObject {
    @Published var transactionHistoryList: [TransactionHistoryModel] = []
    @Published var isLoadingFetching = false
    @Published var isShowingError = false
    @Published var error = ""

    func getListTransactionHistory(token: String) async throws {
        let path = APIPath.getTransactionHistory.stringValue
        let method = HTTPMethod.get
        let headers = ["Authorization": "Bearer \(token)"]

        do {
            isLoadingFetching = true
            let response: CommonResponse<[TransactionHistoryModel]> = try await NetworkManager.shared.callAPI(path: path, method: method, headers: headers, body: nil)
            if let data = response.data {
                transactionHistoryList = data
            } else {
                error = "Warning: No transaction history data received!"
                isShowingError = true
            }

        } catch {
            print("Error at getListTransactionHistory:", error)
            self.error = "Không lấy được danh sách lịch sử giao dịch, xin hãy thử lại!"
            isShowingError = true
        }
        isLoadingFetching = false
    }
}
