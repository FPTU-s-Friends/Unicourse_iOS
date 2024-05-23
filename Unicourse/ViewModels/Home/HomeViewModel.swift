//
//  HomeViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 22/5/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published var slideData = SlideData()
    @Published var allFreeCourse: [CourseDetailModel] = []
    @Published var isLoadingListEnrolled = false
    @Published var isLoadingAllFreeCourse = false
    @Published var error = ""
    @Published var listEnrolledCourses: [EnrolledCourseModel] = []
    private var hasFetched: Bool = false

    func getAllFreeCourse(token: String) {
        isLoadingAllFreeCourse = true
        NetworkManager.shared.callAPI2(path: APIPath.getAllFreeCourse.stringValue, method: .get, headers: ["Authorization": "Bearer \(token)"], body: nil) { (result: Result<CommonResponse<[CourseDetailModel]>, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    switch response.status {
                    case HTTPStatusCodes.OK.rawValue:
                        self.allFreeCourse = response.data
                    default:
                        self.error = "Unexpected status code: \(response.status)"
                    }

                case .failure(let error):
                    print(error)
                    self.error = error.localizedDescription
                }
                self.isLoadingAllFreeCourse = false
            }
        }
    }

    // Comment
    func fetchListEnrolledCourses(userId: String, token: String, isRefresh: Bool) {
        if !isRefresh {
            guard !hasFetched else { return }
        }
        isLoadingListEnrolled = true
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
            self.isLoadingListEnrolled = false
        }
    }

    private func logEnrolledCourses() {
        for course in listEnrolledCourses {
            print(course.trackProgress.count)
        }
    }
}

struct Slide: Identifiable {
    let id = UUID()
    let imageName: String
}

class SlideData: ObservableObject {
    @Published var slides: [Slide] = [
        Slide(imageName: "home-banner1"),
        Slide(imageName: "home-banner2"),
        Slide(imageName: "home-banner3")
    ]
}
