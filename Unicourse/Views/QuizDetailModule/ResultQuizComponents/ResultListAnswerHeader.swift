//
//  ResultListAnswerHeader.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 21/6/24.
//

import SwiftUI

struct ResultListAnswerHeader: View {
    var index: Int
    var questionTitle: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                Text("\(index).")
                    .bold()
                    .frame(width: 30, alignment: .leading) // Fixed width for index
                Text(questionTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    ResultListAnswerHeader(index: 1, questionTitle: "")
}
