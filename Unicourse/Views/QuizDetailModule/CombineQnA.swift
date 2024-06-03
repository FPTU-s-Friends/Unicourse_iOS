//
//  CombineQnA.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 1/6/24.
//

import SwiftUI

struct CombineQnA: View {
    var question: Question
    @State private var isStartAnswerQuestion: Bool = false
    @State private var isChangeYAxisQuestion: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                QuestionComponent(isOpenQuestion: $isStartAnswerQuestion, isChangeYAxisQuestion: $isChangeYAxisQuestion, questionTitle: question.title)
                    .zIndex(1)
                    .offset(y: isChangeYAxisQuestion ? 0 : 180)
                    .animation(.smooth, value: isChangeYAxisQuestion)
                    .onChange(of: isStartAnswerQuestion) { _, newValue in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            isChangeYAxisQuestion = newValue
                        }
                    }

                AnswerComponent(typeAnswer: question.type, listAnswer: question.answer, isShowAnswer: isChangeYAxisQuestion)
                    .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    CombineQnA(question: DetailQuizModel.mockData[0].questions[0])
}
