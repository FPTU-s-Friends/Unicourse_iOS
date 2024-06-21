//
//  ResultListAnswerContent.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 21/6/24.
//

import SwiftUI

struct ResultListAnswerContent: View {
    var typeAnswer: Type_Question
    var listAnswer: [AnswerRequest]
    var isCorrectAnswer: Bool

    var body: some View {
        VStack {
            if isCorrectAnswer == true {
                TrueAnswer()
            } else {
                FalseAnswer()
            }

            if typeAnswer == .single {
                ForEach(Array(listAnswer.enumerated()), id: \.element.id) { index, answer in
                    ResultQuizAnswerItem(isSelected: listAnswer[index].is_checked, index: index, answerType: .single, answerTitle: answer.answer_text, isUserCorrect: isCorrectAnswer, isAnswerCorrect: answer.is_correct)
                }
            } else {
                ForEach(Array(listAnswer.enumerated()), id: \.element.id) { index, answer in
                    ResultQuizAnswerItem(isSelected: listAnswer[index].is_checked, index: index, answerType: .multiple, answerTitle: answer.answer_text, isUserCorrect: isCorrectAnswer, isAnswerCorrect: answer.is_correct)
                }
            }
        }
        .padding()
    }
}

// #Preview {
//    ResultListAnswerContent()
// }

struct TrueAnswer: View {
    var body: some View {
        HStack {
            Image(systemName: "checkmark")
            Text("Bạn làm rất tốt !")
            Spacer()
        }
        .font(.system(size: 14, weight: .semibold))
        .foregroundStyle(Color.trueAnswerText)
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .frame(maxWidth: .infinity)
        .background(Color.trueBackgroundAnswerText)
        .cornerRadius(8)
    }
}

struct FalseAnswer: View {
    var body: some View {
        HStack {
            Image(systemName: "xmark")
            Text("Cố gắng hơn ở lần sau bạn nhé !")
            Spacer()
        }
        .font(.system(size: 14, weight: .semibold))
        .foregroundStyle(Color.falseAnswerText)
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .frame(maxWidth: .infinity)
        .background(Color.falseBackgroundAnswerText)
        .cornerRadius(8)
    }
}
