//
//  SheetCommentView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 3/6/24.
//

import SwiftUI

struct SheetCommentView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var commentText = ""
    var listComment: [Comment_objModel]

    var body: some View {
        NavigationView {
            VStack {
                if listComment.isEmpty {
                    VStack {
                        Text("Hiện chưa có bình luận.")
                    }
                } else {
                    ScrollView {
                        ForEach(listComment, id: \._id) { comment in
                            CommentItemView(comment: comment)

                            if comment.replies.isEmpty {
                                EmptyView()
                            } else {
                                RepliesFieldView(listReplies: comment.replies)
                            }
                        }
                    }
                    .scrollDismissesKeyboard(.immediately)
                    .ignoresSafeArea(.keyboard)
                    .padding(10)
                }

                Spacer()

                HStack {
                    TextField("Thêm bình luận", text: $commentText)
                        .textFieldStyle(CustomTextFieldStyle())

                    Button(action: {
                        // Action for the send button
                    }) {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22)
                            .padding(.trailing)
                    }
                    .disabled(commentText.isEmpty)
                }
                .padding([.horizontal, .bottom], 5)
                .padding(.top, -15)
                .ignoresSafeArea()
            }

            .navigationBarTitle("Bình luận", displayMode: .inline)
        }
    }
}

#Preview {
    SheetCommentView(listComment: [Comment_objModel.sampleCommentData])
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundStyle(.gray)
            .textInputAutocapitalization(.sentences)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.mainColor3.gradient)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
            )
    }
}
