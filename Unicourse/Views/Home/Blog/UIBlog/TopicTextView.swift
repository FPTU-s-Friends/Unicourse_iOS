//
//  TopicTextView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/6/24.
//

import SwiftUI

struct TopicTextView: View {
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .frame(alignment: .leading)

            Spacer()
        }
        .padding(.leading, 10)

        Rectangle()
            .fill(Color.activeColor)
            .frame(width: 90, height: 5)
            .cornerRadius(10)
            .padding(.leading, 10)
            .padding(.top, -15)
    }
}

#Preview {
    TopicTextView(title: "Bài viết gần nhất")
}
