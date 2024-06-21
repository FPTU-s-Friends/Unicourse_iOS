//
//  ResultListAnswer.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/6/24.
//

import SwiftUI

struct ResultListAnswer: View {
    var listAnswerd: [QuestionResponseResult]

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(Array(listAnswerd.enumerated()), id: \.element._id) { index, ques in
                    ExpandableView(thumbnail: ThumbnailView(content: {
                        ResultListAnswerHeader(index: index + 1, questionTitle: ques.title)
                    }), expanded: ExpandedView(content: {
                        VStack(spacing: 0) {
                            ResultListAnswerHeader(index: index + 1, questionTitle: ques.title)
                            ResultListAnswerContent(typeAnswer: ques.type, listAnswer: ques.answer, isCorrectAnswer: ques.user_correct)
                        }
                        .frame(maxWidth: .infinity)
                    }))
                }
            }
        }
    }
}

#Preview {
    ResultListAnswer(listAnswerd: ResultQuizCalculate.mockData.questions)
}
