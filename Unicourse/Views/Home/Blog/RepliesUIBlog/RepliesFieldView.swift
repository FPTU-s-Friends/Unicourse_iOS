//
//  RepliesFieldView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 4/6/24.
//

import SwiftUI

struct RepliesFieldView: View {
    @State private var isShowMoreReplies = false
    var listReplies: [RepliesBlogModel]

    var body: some View {
        VStack {
            if isShowMoreReplies {
                ForEach(listReplies, id: \._id) { reply in
                    RepliesCommentItem(comment: reply)
                        .padding(.leading, 30)
                }
            }
            Button(action: {
                withAnimation {
                    isShowMoreReplies.toggle()
                }
            }, label: {
                Image(systemName: isShowMoreReplies ? "chevron.up" : "chevron.down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
                    .foregroundStyle(Color.mainColor1.gradient)

            })
        }
    }
}

#Preview {
    RepliesFieldView(listReplies: [.sampleReplyData])
}
