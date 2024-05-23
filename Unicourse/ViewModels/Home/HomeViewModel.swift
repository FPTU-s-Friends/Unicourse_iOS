//
//  HomeViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 22/5/24.
//

import Foundation

enum Order {
    case DES
    case ASC

    var toString: String {
        switch self {
        case .DES:
            return "desc"
        case .ASC:
            return "asc"
        }
    }
}

class HomeViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published var slideData = SlideData()
    @Published var allFreeCourse: [CourseModel] = []
    @Published var isLoadingListEnrolled = false
    @Published var isLoadingAllFreeCourse = false
    @Published var isLoadingGetUser = false
    @Published var error = ""
    @Published var listEnrolledCourses: [EnrolledCourseModel] = []
    @Published var listLectures: [LectureModel] = []
    private var hasFetched: Bool = false

    func getAllFreeCourse(token: String) {
        isLoadingAllFreeCourse = true
        NetworkManager.shared.callAPI2(path: APIPath.getAllFreeCourse.stringValue, method: .get, headers: ["Authorization": "Bearer \(token)"], body: nil) { (result: Result<CommonResponse<[CourseModel]>, Error>) in
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

    // get list enrolled course
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

    func getUsersPaginationByRole(role: UserRole, pageSize: Int, pageNum: Int, sortBy: String, order: Order, token: String) {
        isLoadingGetUser = true

        let parameters: [String: Any] = [
            "role": role.rawValue,
            "pageSize": pageSize,
            "pageNum": pageNum,
            "sortBy": sortBy,
            "order": order.toString
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)

            NetworkManager.shared.callAPI2(path: APIPath.getUsers.stringValue,
                                           method: .post,
                                           headers: ["Authorization": "Bearer \(token)"],
                                           body: jsonData)
            {
                (result: Result<CommonResponse<PaginationResponse<[LectureModel]>>, Error>) in

                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        switch response.status {
                        case HTTPStatusCodes.OK.rawValue:
                            self.listLectures = response.data.data
                        default:
                            self.error = "Unexpected status code: \(response.status)"
                        }
                    case .failure(let error):
                        print(error)
                        self.error = error.localizedDescription
                    }
                    self.isLoadingGetUser = false
                }
            }
        } catch {
            print("Error encoding parameters: \(error)")
            self.error = "Error preparing request" // Inform user about the issue
            isLoadingGetUser = false
        }
    }

    private func logEnrolledCourses() {
        for course in listEnrolledCourses {
            print(course.trackProgress?.count)
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
