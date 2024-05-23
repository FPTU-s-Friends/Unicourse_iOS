//
//  CourseViewModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 21/5/24.
//

import Foundation

class CourseViewModel: ObservableObject {
    @Published var listEnrolledCourses: [EnrolledCourseModel] = []
    @Published var isLoading: Bool = false
    private var hasFetched: Bool = false

    // Comment
    func fetchListEnrolledCourses(userId: String, token: String, isRefresh: Bool) {
        if !isRefresh {
            guard !hasFetched else { return }
        }
        isLoading = true
        NetworkManager.shared.callAPI2(path: APICoursePath.getEnrolledCourseByUserId(userId: userId).endPointValue, method: .get, headers: ["Authorization": "Bearer \(token)"], body: nil) { (result: Result<CommonResponse<[EnrolledCourseModel]>, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.listEnrolledCourses = response.data
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
        for course in listEnrolledCourses {
            print(course.trackProgress?.count)
        }
    }
}
