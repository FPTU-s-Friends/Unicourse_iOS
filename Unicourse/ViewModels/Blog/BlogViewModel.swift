//
//  BlogViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/6/24.
//

import Foundation

class BlogViewModel: ObservableObject {
    @Published var searchString = ""
    @Published var listBlogs: [BlogModel] = []
    @Published var highLightBlogs: [BlogModel] = []
    @Published var error = ""
    @Published var isShowingError = false
    @Published var isLoadingFetchBlog = false
    @Published var currentPage = 1

    func getListBlog() async throws {
        let path = APIPath.getBlogs.stringValue
        let method = HTTPMethod.get
        let params: [String: Any] = ["page": currentPage]

        do {
            let response: CommonResponse<[BlogModel]> = try await NetworkManager.shared.callAPI(path: path, method: method, parameters: params, body: nil)
            listBlogs = response.data
        } catch {
            self.error = "Không lấy được danh sách blog"
            isShowingError = true
            print(error)
        }
    }

    func getHighlightBlog() async throws {
        let path = APIPath.getHighlightBlog.stringValue
        let method = HTTPMethod.get

        do {
            let response: CommonResponse<[BlogModel]> = try await NetworkManager.shared.callAPI(path: path, method: method, body: nil)
            highLightBlogs = response.data
        } catch {
            self.error = "Không lấy được danh sách blog"
            isShowingError = true
            print(error)
        }
    }
}
