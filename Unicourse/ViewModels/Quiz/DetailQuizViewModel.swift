//
//  DetailQuizViewModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 3/6/24.
//

import Foundation

class DetailQuizViewModel: ObservableObject {
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
                    if let data = response.data {
                        self.quizData = data
                        self.answeredQuesList = data.questions.map { ques in
                            var answers: [AnswerRequest] = []
                            for answer in ques.answer {
                                answers.append(AnswerRequest(answer_text: answer.answer_text,
                                                             is_correct: answer.is_correct,
                                                             is_checked: false,
                                                             is_answered: false))
                            }
                            return QuestionRequest(_id: ques._id,
                                                   title: ques.title,
                                                   type: ques.type,
                                                   is_answered: false,
                                                   answer: answers)
                        }
                    } else {
                        print("Get quiz by id data is nil!")
                    }
                }
            case .failure(let err):
                print(err)
            }
            self.isLoading = false
        }
    }

    func setCheckedForIndexAnswer(questionId: String, indexAnswered: Int) {
        if answeredQuesList.firstIndex(where: { $0._id == questionId }) != nil {
            // Tạo một bản sao mới của mảng answeredQuesList
            answeredQuesList = answeredQuesList.map { question in
                // Tạo một bản sao của question
                var newQuestion = question

                // Kiểm tra nếu question hiện tại là question cần thay đổi
                if newQuestion._id == questionId {
                    // Đặt tất cả các câu trả lời khác thành is_checked = false
                    newQuestion.answer = newQuestion.answer.map { answer in
                        var newAnswer = answer
                        newAnswer.is_checked = (answer.answer_text == newQuestion.answer[indexAnswered].answer_text)
                        return newAnswer
                    }

                    // Đặt câu trả lời tại indexAnswered thành is_checked = true
                    newQuestion.answer[indexAnswered].is_checked = true
                    newQuestion.is_answered = true
                }

                return newQuestion
            }
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
        }
    }

    func combineInformationToGetResult() {
        let newRequest = QuizRequestModel(
            _id: quizData?._id ?? "",
            title: quizData?.title ?? "",
            description: quizData?.description ?? "",
            picture: quizData?.picture ?? "",
            questions: answeredQuesList,
            status: quizData?.status ?? "",
            category: quizData?.category ?? "",
            creator_id: quizData?.creator_id ?? data.creator_id,
            viewer: quizData?.viewer ?? 0,
            creator_role: quizData?.creator_role ?? "")

        printJSONData(data: newRequest)
    }

    func createQuestionListResult(questionList: [Question]) -> [QuestionRequest] {
        questionList.map { ques in
            QuestionRequest(_id: ques._id, title: ques.title, type: ques.type, is_answered: false, answer: ques.answer.map { answer in
                AnswerRequest(answer_text: answer.answer_text, is_correct: answer.is_correct, is_checked: false, is_answered: false)
            })
        }
    }
}
