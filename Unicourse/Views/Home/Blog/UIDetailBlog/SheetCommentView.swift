//
//  SheetCommentView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 3/6/24.
//

import SwiftUI

struct SheetCommentView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var appData: AppData
    @ObservedObject var viewModel: DetailBlogViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.blogDetail?.comment_obj == nil || ((viewModel.blogDetail?.comment_obj.isEmpty) == nil) {
                    VStack {
                        Text("Hiện chưa có bình luận.")
                    }
                } else {
                    ScrollView {
                        ForEach(viewModel.blogDetail?.comment_obj ?? [], id: \._id) { comment in
                            CommentItemView(comment: comment, actionsLikeBlog: {
                                Task {
                                    guard let userId = appData.userInfo?._id else { return }
                                    try await viewModel.likeUnLikeComment(commentId: comment._id,
                                                                          token: appData.token,
                                                                          userId: userId)
                                }
                            }, isLoadingLike: $viewModel.isLoadingLikeComment)

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
                    TextField("Thêm bình luận", text: $viewModel.commentText)
                        .textFieldStyle(CustomTextFieldStyle())
                        .frame(height: 50)

                    Button(action: {
                        Task {
                            guard let userInfo = appData.userInfo else { return }
                            try await viewModel.commentBlog(blogId: viewModel.blogDetail?._id ?? "",
                                                            token: appData.token,
                                                            comment: viewModel.commentText,
                                                            userInfo: userInfo)
                        }
                    }) {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22)
                            .padding(.trailing)
                    }
                    .disabled(viewModel.commentText.isEmpty)
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
    SheetCommentView(viewModel: DetailBlogViewModel())
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
