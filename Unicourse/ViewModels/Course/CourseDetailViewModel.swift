//
//  CourseDetailViewModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/5/24.
//

import Foundation

class CourseDetailViewModel: ObservableObject {
    @Published var courseDetail: CourseDetailModel? = nil
    @Published var isLoading: Bool = false
    private var hasFetched: Bool = false

    func fetchCourseDetailById(courseId: String) {
        isLoading = true
        guard !hasFetched else { return }
        NetworkManager.shared.callAPI2(path: APICoursePath.getDetailCourseById(courseId: courseId).endPointValue, method: .get, body: nil) { (result: Result<CommonResponse<CourseDetailModel>, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.courseDetail = response.data
                    self.logEnrolledCourses()
                }
                self.hasFetched = true
            case .failure(let error):
                print(error)
            }
            self.isLoading = false
        }
    }

    private func logEnrolledCourses() {
        if courseDetail != nil {
            print(courseDetail?.lecture)
        }
    }
}
