//
//  TopicBlogView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/6/24.
//

import SwiftUI

struct TopicBlogView: View {
    var body: some View {
        HStack(spacing: 3) {
            Text("Chủ đề:")
                .font(.system(size: 12, weight: .bold))
                .lineLimit(1)
                .padding(.vertical, 4)
                .padding(.leading, 10)

            Text("Tâm sự")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .padding(.vertical, 4)
                .padding(.horizontal, 6)
                .background(Color.mainColor1)
                .cornerRadius(5)

            Text("Thông tin")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .padding(.vertical, 4)
                .padding(.horizontal, 6)
                .background(Color.green)
                .cornerRadius(5)

            Spacer()
        }
    }
}

#Preview {
    TopicBlogView()
}
