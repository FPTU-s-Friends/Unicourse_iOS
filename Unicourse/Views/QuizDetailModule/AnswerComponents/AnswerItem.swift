//
//  AnswerItem.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 1/6/24.
//

import SwiftUI

struct AnswerItem: View {
    var isSelected: Bool = false
    var index: Int
    var answerType: Type_Question
    var answerTitle: String

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(answerTitle)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 14, weight: .regular))
                Spacer()

                if isSelected {
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
        .background(isSelected ? Color(hex: "#ecfdf5") : .white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color(hex: "#6ee7b7"), lineWidth: isSelected ? 1 : 0.1)
        )
        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 1)
    }
}

#Preview {
    AnswerItem(isSelected: true, index: 0, answerType: .multiple, answerTitle: "")
}
