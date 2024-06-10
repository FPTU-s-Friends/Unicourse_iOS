//
//  QuizViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 31/5/24.
//

import Foundation

enum TypeFilter: String, CaseIterable {
    case filterDefault = "Mặc định"
    case filterNewest = "Mới nhất"
    case filterMostView = "Học nhiều nhất"
}

let options = ["Kỳ 1", "Kỳ 2", "Kỳ 3", "Kỳ 4", "Kỳ 5", "Kỳ 6", "Kỳ 7", "Kỳ 8", "Kỳ 9"]

class QuizViewModel: ObservableObject {
    @Published var searchString = ""
    @Published var isSearchBarVisible = false
    @Published var isPresentedFilter = false
    @Published var isShowingAlert = false
    @Published var isLoadingFetch = false
    @Published var listAllQuizzes: [AllQuizModel] = []
    @Published var filterSelected: TypeFilter = .filterDefault
    @Published var filterSelectedOption = 0

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
