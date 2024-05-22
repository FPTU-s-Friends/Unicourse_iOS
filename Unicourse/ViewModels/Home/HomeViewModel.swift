//
//  HomeViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 22/5/24.
//

import Foundation

struct Slide: Identifiable {
    let id = UUID()
    let imageName: String
}

class SlideData: ObservableObject {
    @Published var slides: [Slide] = [
        Slide(imageName: "home-banner1"),
        Slide(imageName: "home-banner2"),
        Slide(imageName: "home-banner1")
    ]
}

class HomeViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published var slideData = SlideData()
    @Published var allFreeCourse: [CourseDetailModel] = []
    @Published var isLoading = false
    @Published var error = ""

    func getAllFreeCourse(token: String) {
        self.isLoading = true
        NetworkManager.shared.callAPI2(path: APIPath.getAllFreeCourse.stringValue, method: .get, headers: ["Authorization": "Bearer \(token)"], body: nil) { (result: Result<CommonResponse<CourseDetailModel>, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    switch response.status {
                    case HTTPStatusCodes.OK.rawValue:
                        print(response)
                        self.allFreeCourse = response.data
                    default:
                        self.error = "Unexpected status code: \(response.status)"
                        print(response.data)
                    }

                case .failure(let error):
                    print(error)
                    self.error = error.localizedDescription
                }
                self.isLoading = false
            }
        }
    }
}
