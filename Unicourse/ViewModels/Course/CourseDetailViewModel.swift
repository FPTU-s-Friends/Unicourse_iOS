//
//  CourseDetailViewModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/5/24.
//

import Foundation

class CourseDetailViewModel: ObservableObject {
    @Published var courseDetail: CourseModel? = nil
    @Published var isLoading: Bool = false
    @Published var isLoadingEnroll: Bool = false
    @Published var isShowSuccess: Bool = false
    @Published var isLoadingAddToCart = false
    @Published var isAddTocartSuccess = false
    @Published var isShowingError = false

    @Published var error = ""
    @Published var newCourseEnrolled: EnrolledNewCourseModel? = nil

    func fetchCourseDetailById(courseId: String) {
        isLoading = true

        NetworkManager.shared.callAPI2(path: APICoursePath.getDetailCourseById(courseId: courseId).endPointValue, method: .get, body: nil) { (result: Result<CommonResponse<CourseModel>, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.courseDetail = response.data
                }
            case .failure(let error):
                print(error)
            }
            self.isLoading = false
        }
    }

    func enrolledNewCourse(courseId: String, token: String, appData: AppData) {
        isLoadingEnroll = true
        NetworkManager.shared.callAPI2(path: APICoursePath.enrollNewCourse(courseId: courseId).endPointValue, method: .post, headers: ["Authorization": "Bearer \(token)"], body: nil) { (result: Result<CommonResponse<EnrolledNewCourseModel>, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.newCourseEnrolled = response.data
                    appData.listCurrentEnrolled.append((response.data?.course._id)!)
                }
            case .failure(let err):
                print(err)
            }
            self.isLoadingEnroll = false
            self.isShowSuccess = true
        }
    }

    func addToCart(token: String) async throws {
        let path = APIPath.addToCart.stringValue
        let method = HTTPMethod.post
        let headers = ["Authorization": "Bearer \(token)"]

        do {
            let response: CommonResponse<AddToCartResponseModel> = try await NetworkManager.shared.callAPI(path: "\(path)/\(courseDetail?._id ?? "")", method: method, headers: headers, body: nil)
            if let data = response.data {
                isAddTocartSuccess = true
            } else {
                error = "Add to cart không thành công!, hãy thử lại"
                isShowingError = true
            }

        } catch {
            print("Error at addToCart:", error)
            self.error = "Add to cart không thành công!, hãy thử lại"
            isShowingError = true
        }
    }

    private func logEnrolledCourses() {
        if courseDetail != nil {
            print(courseDetail?.lecture)
        }
    }
}
