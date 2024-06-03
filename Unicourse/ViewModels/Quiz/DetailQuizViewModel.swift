//
//  DetailQuizViewModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 3/6/24.
//

import Foundation

class DetailQuizViewModel: ObservableObject {
    // MockData
    @Published var data = DetailQuizModel.mockData
    @Published var selectedTab: Int = 0
    @Published var quizData: DetailQuizModel? = nil
    @Published var isLoading: Bool = false

    func getQuizById(quizId: String) {
        isLoading = true
        NetworkManager.shared.callAPI2(path: APIQuizPath.getQuizById(quizId: quizId).endPointValue, method: .get, body: nil) {
            (result: Result<CommonResponse<DetailQuizModel>, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.quizData = response.data
                }
            case .failure(let err):
                print(err)
            }
            self.isLoading = false
        }
    }
}
