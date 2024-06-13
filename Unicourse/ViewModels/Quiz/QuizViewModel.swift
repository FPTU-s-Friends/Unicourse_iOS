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

let options = ["Chọn Kỳ", "Kỳ 1", "Kỳ 2", "Kỳ 3", "Kỳ 4", "Kỳ 5", "Kỳ 6", "Kỳ 7", "Kỳ 8", "Kỳ 9"]

let semesters = ["CN1", "CN2", "CN3", "CN4", "CN5", "CN6", "CN7", "CN8", "CN9"]

class QuizViewModel: ObservableObject {
    @Published var searchString = ""
    @Published var isSearchBarVisible = false
    @Published var isPresentedFilter = false
    @Published var isShowingAlert = false
    @Published var isLoadingFetch = false
    @Published var listAllQuizzes: [AllQuizModel] = []
    @Published var filterSelected: TypeFilter = .filterDefault
    @Published var filterSelectedOption = 0
    @Published var listFilterQuizzes: [AllQuizModel] = []

    @Published var error = ""

    func getAllQuizzes() async {
        do {
            let response = try await fetchQuizzes()
            if let data = response.data {
                listAllQuizzes = data
                listFilterQuizzes = listAllQuizzes
            } else {
                print("get All Quizzes data is nil!")
                listAllQuizzes = []
            }

        } catch {
            print("Error at fetch quizzes", error)
            self.error = error.localizedDescription
            isShowingAlert = true
        }
    }

    func filterQuizzes() {
        switch filterSelected {
        case .filterNewest:
            // Sort by creation date
            listFilterQuizzes = listAllQuizzes.sorted { $0.created_at > $1.created_at }
        case .filterMostView:
            // Sort by number of viewers
            listFilterQuizzes = listAllQuizzes.sorted { $0.viewer > $1.viewer }
        default:
            // For other cases or default, retain the original list of quizzes
            listFilterQuizzes = listAllQuizzes
        }

        if filterSelectedOption > 0 {
            let selectedSemester = semesters[filterSelectedOption - 1]
            listFilterQuizzes = listFilterQuizzes.filter { $0.category.rawValue == selectedSemester }
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
            return listFilterQuizzes
        } else {
            return listFilterQuizzes.filter { $0.title.localizedCaseInsensitiveContains(searchString) }
        }
    }
}
