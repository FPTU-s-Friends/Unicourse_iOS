//
//  DetailBlogViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import SwiftUI

class DetailBlogViewModel: ObservableObject {
    @Published var webViewHeight: CGFloat = 0
    @Published var blogDetail: DetailBlogModel?
    @Published var listRelatedBlog: [BlogModel] = []
    @Published var error = ""
    @Published var isLoadingGetBlog = false
    @Published var isShowingDescription = true
    @Published var isShowingSheetComment = false
    @Published var isShowingError = false
    @Published var isLoadingLike = false

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
            isLoadingGetBlog = true
            let response: CommonResponse<[BlogModel]> = try await NetworkManager.shared.callAPI(path: path, method: method, parameters: params, body: nil)
            listRelatedBlog = response.data
        } catch {
            print("Error at getBlogById:", error)
            self.error = "Không lấy được thông tin của blog, hãy thử lại"
            isShowingError = true
        }
        isLoadingGetBlog = false
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
}
