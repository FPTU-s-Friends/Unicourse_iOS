//
//  CommentItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 3/6/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct CommentItemView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var comment: Comment_objModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                WebImage(url: URL(string: comment.commentator.profile_image ?? DefaultURL.defaultUserURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .cornerRadius(20)
                } placeholder: {
                    ProgressView()
                }
                Text(comment.commentator.fullName)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)

                Text("\(timeSinceCreated(date: comment.created_at))")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)

                Spacer()

                Menu { // Remove the "Options" label here
                    Button("Chỉnh sửa", action: {})
                    Button("Xoá", action: {})
                    Button("Cancel", action: {})
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                }
            }

            VStack {
                TextCommentItem(text: comment.comment)
                    .padding(.vertical, -8)
            }

            HStack(spacing: 0) {
                Button {} label: {
                    Image(systemName: "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                        .frame(width: 16)
                }

                Text("(\(comment.interactions.count))")
                    .font(.system(size: 13))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .foregroundStyle(Color.red.gradient)
                    .padding(.horizontal, 1)

                Button {} label: {
                    Text("Trả lời")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                }
                .padding(.leading, 10)
            }
            .padding(.horizontal, 5)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background {
            Color.mainBackgroundColor.cornerRadius(10)
        }
    }
}

#Preview {
    CommentItemView(comment: Comment_objModel.sampleCommentData)
}
