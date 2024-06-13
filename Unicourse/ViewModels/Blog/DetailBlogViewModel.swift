//
//  DetailBlogViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import SwiftUI

class DetailBlogViewModel: ObservableObject {
    @Published var commentText = ""
    @Published var webViewHeight: CGFloat = 0
    @Published var blogDetail: DetailBlogModel?
    @Published var listRelatedBlog: [BlogModel] = []
    @Published var error = ""
    @Published var isLoadingGetRelatedBlogisLoadingGetBlog = false
    @Published var isShowingDescription = true
    @Published var isShowingSheetComment = false
    @Published var isShowingError = false
    @Published var isLoadingLike = false
    @Published var isLoadingCommentBlog = false
    @Published var isLoadingLikeComment = false
    @Published var isLoadingGetRelatedBlog = false
    @Published var isLoadingGetBlog = false

    func getBlogById(blogId: String) async throws {
        let path = APIPath.getBlogs.stringValue
        let method = HTTPMethod.get
        do {
            isLoadingGetBlog = true
            let response: CommonResponse<DetailBlogModel> = try await NetworkManager.shared.callAPI(path: "\(path)/\(blogId)", method: method, body: nil)
            blogDetail = response.data
        } catch {
            print("Error at getBlogById:", error)
            self.error = "Không lấy được thông tin của blog, hãy thử lại"
            isShowingError = true
        }
        isLoadingGetBlog = false
    }

    func getRelatedBlog() async throws {
        let path = APIPath.getBlogs.stringValue
        let method = HTTPMethod.get
        let params: [String: Any] = ["page": 1]

        do {
            isLoadingGetRelatedBlog = true
            let response: CommonResponse<[BlogModel]> = try await NetworkManager.shared.callAPI(path: path, method: method, parameters: params, body: nil)
            if let data = response.data {
                listRelatedBlog = data
            } else {
                print("Get Related Blog data is nil!")
            }

        } catch {
            print("Error at getBlogById:", error)
            self.error = "Không lấy được thông tin của blog, hãy thử lại"
            isShowingError = true
        }
        isLoadingGetRelatedBlog = false
    }

    func likeBlog(blogId: String, token: String) async throws {
        let path = APIPath.likeBlog.stringValue
        let method = HTTPMethod.post
        let headers = ["Authorization": "Bearer \(token)"]
        let requestBody = RequestBody(blogId: blogId)

        guard let bodyData = try? JSONEncoder().encode(requestBody) else {
            throw NetworkError.encodingError
        }

        isLoadingLike = true
        let _: CommonResponse<String> = try await NetworkManager.shared.callAPI(path: path, method: method, headers: headers, body: bodyData)
    }

    func unLikeBlog(blogId: String, token: String) async throws {
        let path = APIPath.unlikeBlog.stringValue
        let method = HTTPMethod.post
        let headers = ["Authorization": "Bearer \(token)"]
        let requestBody = RequestBody(blogId: blogId)

        do {
            guard let bodyData = try? JSONEncoder().encode(requestBody) else {
                throw NetworkError.encodingError
            }

            isLoadingLike = true
            let _: CommonResponse<String> = try await NetworkManager.shared.callAPI(path: path, method: method, headers: headers, body: bodyData)

        } catch {
            print("Error at Like Blog:", error)
            self.error = "unLike blog không thành công, hãy thử lại"
            isShowingError = true
        }
        isLoadingLike = false
    }

    func commentBlog(blogId: String, token: String, comment: String, userInfo: UserInfoModel) async throws {
        let path = APIPath.comment.stringValue
        let method = HTTPMethod.post
        let headers = ["Authorization": "Bearer \(token)"]
        let requestBody = CommentBlogRequestModel(blogId: blogId, comment: comment)

        do {
            guard let bodyData = try? JSONEncoder().encode(requestBody) else {
                throw NetworkError.encodingError
            }
            isLoadingCommentBlog = true
            let response: CommonResponse<CommentBlogResponseModel> = try await NetworkManager.shared.callAPI(path: path, method: method, headers: headers, body: bodyData)
            guard let data = response.data else {
                return
            }
            blogDetail?.comment_obj.append(Comment_objModel(_id: data._id,
                                                            comment: data.comment,
                                                            commentator: BlogCommentatorModel(_id: data._id,
                                                                                              email: userInfo.email,
                                                                                              fullName: userInfo.fullName,
                                                                                              profileName: userInfo.profileName ?? "",
                                                                                              profile_image: userInfo.profileImage),
                                                            replies: [],
                                                            interactions: [],
                                                            created_at: data.created_at))

            commentText = ""
        } catch {
            print("Error at Comment Blog:", error)
            self.error = "Bình luận chưa được, hãy thử lại"
            isShowingError = true
        }
    }

    func likeUnLikeComment(commentId: String, token: String, userId: String) async throws {
        let path = APIPath.likeAndUnlikeComment.stringValue
        let method = HTTPMethod.post
        let headers = ["Authorization": "Bearer \(token)"]
        let requestBody = LikeUnLikeCommentBlogRequestModel(commentId: commentId)

        do {
            guard let bodyData = try? JSONEncoder().encode(requestBody) else {
                throw NetworkError.encodingError
            }
            isLoadingLikeComment = true
            let response: CommonResponse<CommentBlogResponseModel> = try await NetworkManager.shared.callAPI(path: path, method: method, headers: headers, body: bodyData)

            if let commentIndex = blogDetail?.comment_obj.firstIndex(where: { $0._id == commentId }) {
                var updatedComment = blogDetail?.comment_obj[commentIndex]

                // Update the comment_obj array (if blogDetail is not nil)
                if var blogDetail = blogDetail {
                    blogDetail.comment_obj[commentIndex].interactions.append(userId)
                }
            }
        } catch {
            print("Error at Like Comment Blog:", error)
            self.error = "Like Bình luận không thành công, hãy thử lại"
            isShowingError = true
        }
        isLoadingLikeComment = false
    }
}
