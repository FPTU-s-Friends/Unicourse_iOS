//
//  ResultQuizAnswerItem.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 21/6/24.
//

import SwiftUI

struct ResultQuizAnswerItem: View {
    var isSelected: Bool = false
    var index: Int
    var answerType: Type_Question
    var answerTitle: String
    var isUserCorrect: Bool
    var isAnswerCorrect: Bool

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(answerTitle)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 14, weight: .regular))
                Spacer()

                if isSelected {
                    //  Trường hợp đúng
                    if isUserCorrect {
                        Image(systemName: answerType == .single ? "checkmark.circle.fill" : "checkmark.square.fill")
                            .font(.system(size: 19, weight: .semibold))
                            .foregroundStyle(Color.green)
                            .padding(.leading, 2)
                    } else {
                        // Trường hợp sai
                        Image(systemName: answerType == .single ? "xmark.circle.fill" : "xmark.square.fill")
                            .font(.system(size: 19, weight: .semibold))
                            .foregroundStyle(Color.red)
                            .padding(.leading, 2)
                    }

                } else if isAnswerCorrect {
                    Image(systemName: answerType == .single ? "checkmark.circle.fill" : "checkmark.square.fill")
                        .font(.system(size: 19, weight: .semibold))
                        .foregroundStyle(Color.green)
                        .padding(.leading, 2)
                } else {
                    Image(systemName: answerType == .single ? "circle" : "square")
                        .font(.system(size: 20, weight: .ultraLight))
                        .foregroundStyle(Color.neutralTextColor)
                        .padding(.leading, 2)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .frame(maxWidth: .infinity)
        .background((isSelected && isUserCorrect) || isAnswerCorrect ? Color(hex: "#dcfce7") : (isSelected && !isUserCorrect ? Color(hex: "#ffebee") : Color.white))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke((isSelected && isUserCorrect) || isAnswerCorrect ? Color.green : (isSelected && !isUserCorrect ? Color.red : Color.clear), lineWidth: 1)
        )
        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 1)
    }
}

#Preview {
    ResultQuizAnswerItem(isSelected: true, index: 0, answerType: .single, answerTitle: "", isUserCorrect: false, isAnswerCorrect: false)
}
