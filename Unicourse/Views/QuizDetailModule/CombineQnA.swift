//
//  CombineQnA.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 1/6/24.
//

import SwiftUI

struct CombineQnA: View {
    var question: QuestionRequest
    var questionIndex: Int
    @State private var isStartAnswerQuestion: Bool = false
    @State private var isChangeYAxisQuestion: Bool = false

    @ObservedObject var vm: DetailQuizViewModel

    var body: some View {
        ScrollView {
            VStack {
                QuestionComponent(isOpenQuestion: $isStartAnswerQuestion, isChangeYAxisQuestion: $isChangeYAxisQuestion, questionTitle: question.title, questionIndex: questionIndex)
                    .zIndex(1)
                    .offset(y: isChangeYAxisQuestion ? 0 : 180)
                    .animation(.smooth, value: isChangeYAxisQuestion)
                    .onChange(of: isStartAnswerQuestion) { _, newValue in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            isChangeYAxisQuestion = newValue
                        }
                    }

                AnswerComponent(
                    typeAnswer: question.type,
                    listAnswer: question.answer,
                    isShowAnswer: isChangeYAxisQuestion,
                    question_id: question._id,
                    vm: vm)
                    .padding(.bottom, 20)
            }
        }
        .scrollIndicators(.hidden)
    }
}

// #Preview {
//    CombineQnA(question: DetailQuizModel.mockData.questions[0], questionIndex: 1)
// }
