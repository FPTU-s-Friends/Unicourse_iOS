//
//  RepliesCommentItem.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 4/6/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct RepliesCommentItem: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var comment: RepliesBlogModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                WebImage(url: URL(string: comment.commentator.profile_image ?? DefaultURL.defaultUserURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35)
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
                
                Button(action: {}, label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                })
            }
            
            VStack {
                TextCommentItem(text: comment.comment)
                    .padding(.vertical, -8)
            }
            
            HStack {
                Button {} label: {
                    Image(systemName: "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                        .frame(width: 16)
                }
                
                Text("(\(comment.interactions.count))")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .foregroundStyle(Color.red.gradient)
                
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
    RepliesCommentItem(comment: RepliesBlogModel.sampleReplyData)
}
