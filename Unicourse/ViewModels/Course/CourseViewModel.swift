//
//  CourseViewModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 21/5/24.
//

import Foundation

class CourseViewModel: ObservableObject {
    @Published var listEnrolledCourses: [EnrolledCourseModel] = []

    func fetchListEnrolledCourses(userId: String, token: String) {
        NetworkManager.shared.callAPI2(path: APIUserPath.getEnrolledCourseByUserId(userId: userId).endPointValue, method: .get, headers: ["Authorization": "Bearer \(token)"], body: nil) { (result: Result<CommonResponse<EnrolledCourseModel>, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.listEnrolledCourses = response.data
                    self.logEnrolledCourses()
                }

            case .failure(let error):
                print(error)
            }
        }
    }

    private func logEnrolledCourses() {
        for course in listEnrolledCourses {
            print(course)
        }
    }
}
