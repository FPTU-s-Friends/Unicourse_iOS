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
    @Published var answeredQuesList: [QuestionRequest] = []

    func getQuizById(quizId: String) {
        isLoading = true
        NetworkManager.shared.callAPI2(path: APIQuizPath.getQuizById(quizId: quizId).endPointValue, method: .get, body: nil) {
            (result: Result<CommonResponse<DetailQuizModel>, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.quizData = response.data
                    // Set new
                    self.answeredQuesList = response.data.questions.map { ques in
                        QuestionRequest(_id: ques._id, title: ques.title, type: ques.type, is_answered: false, answer: ques.answer.map { answer in
                            AnswerRequest(answer_text: answer.answer_text, is_correct: answer.is_correct, is_checked: false, is_answered: false)
                        })
                    }
                }
            case .failure(let err):
                print(err)
            }
            self.isLoading = false
        }
    }

    func setCheckedForIndexAnswer(questionId: String, indexAnswered: Int) {
        if let index = answeredQuesList.firstIndex(where: { $0._id == questionId }) {
            // Đặt tất cả các câu trả lời khác thành is_checked = false
            for i in 0 ..< answeredQuesList[index].answer.count {
                if i != indexAnswered {
                    answeredQuesList[index].answer[i].is_checked = false
                }
            }

            // Đặt câu trả lời tại indexAnswered thành is_checked = true
            answeredQuesList[index].answer[indexAnswered].is_checked = true
            answeredQuesList[index].is_answered = true
            printJSONData(data: answeredQuesList[index])

            print("**************************")
        }
    }

    func setCheckedForMultipleAnswer(questionId: String, indexAnswered: Int) {
        if let index = answeredQuesList.firstIndex(where: { $0._id == questionId }) {
            if answeredQuesList[index].answer[indexAnswered].is_checked == true {
                answeredQuesList[index].answer[indexAnswered].is_checked = false
            } else {
                answeredQuesList[index].answer[indexAnswered].is_checked = true
            }
            answeredQuesList[index].is_answered = true
            printJSONData(data: answeredQuesList[index])
            print("**************************")
        }
    }

//    func combineInformationToGetResult() {
//        var newRequest = QuizRequestModel(
//            _id: quizData?._id ?? "",
//            title: quizData?.title ?? "",
//            description: quizData?.description ?? "",
//            picture: quizData?.picture ?? "",
//            questions: answeredQuesList,
//            status: quizData?.status ?? "",
//            category: quizData?.category ?? "",
//            creator_id: quizData?.creator_id ?? <#default value#>,
//            viewer: quizData?.viewer,
//            creator_role: quizData?.creator_role)
//    }

    func createQuestionListResult(questionList: [Question]) -> [QuestionRequest] {
        questionList.map { ques in
            QuestionRequest(_id: ques._id, title: ques.title, type: ques.type, is_answered: false, answer: ques.answer.map { answer in
                AnswerRequest(answer_text: answer.answer_text, is_correct: answer.is_correct, is_checked: false, is_answered: false)
            })
        }
    }
}
