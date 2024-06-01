//
//  QuizViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 31/5/24.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var searchString = ""
    @Published var isSearchBarVisible = false
    @Published var isPresentedFilter = false
    @Published var isShowingAlert = false
    @Published var isLoadingFetch = false
    @Published var listAllQuizzes: [AllQuizModel] = []
    @Published var error = ""

    func getAllQuizzes() async {
        do {
            let response = try await fetchQuizzes()
            listAllQuizzes = response.data
        } catch {
            print(error)
            self.error = error.localizedDescription
            isShowingAlert = true
        }
    }

    private func fetchQuizzes() async throws -> CommonResponse<[AllQuizModel]> {
        let path = APIPath.getQuiz.stringValue
        let method = HTTPMethod.get
        let headers = ["Content-Type": "application/json"]

        return try await NetworkManager.shared.callAPI(path: path, method: method, headers: headers, body: nil)
    }

    var filteredQuizzes: [AllQuizModel] {
        if searchString.isEmpty {
            listAllQuizzes
        } else {
            listAllQuizzes.filter { $0.title.localizedCaseInsensitiveContains(searchString) }
        }
    }
}
