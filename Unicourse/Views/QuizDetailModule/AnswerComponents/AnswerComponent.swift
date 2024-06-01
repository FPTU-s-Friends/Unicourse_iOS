//
//  AnswerCard.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 1/6/24.
//

import SwiftUI

struct AnswerComponent: View {
    @State private var selectedAnswerIndex: Int? = nil
    @State private var isExpandedAnswer: Bool = false
    var isShowAnswer: Bool

    var body: some View {
        VStack(spacing: 15) {
            ForEach(0 ..< 4) { index in
                AnswerItem(isSelected: selectedAnswerIndex == index, index: index)
                    .animation(.spring, value: isShowAnswer)
                    .offset(y: isShowAnswer ? 0 : CGFloat(-65 * index))
                    .opacity(isShowAnswer ? 1 : 0)
                    .onTapGesture {
                        withAnimation {
                            selectedAnswerIndex = index
                        }
                    }
                    .onChange(of: isShowAnswer) { _, newValue in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) {
                            isExpandedAnswer = newValue
                        }
                    }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AnswerComponent(isShowAnswer: true)
}
