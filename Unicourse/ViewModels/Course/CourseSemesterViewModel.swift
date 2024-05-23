//
//  CourseSemesterViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import Foundation

class CourseSemesterViewModel: ObservableObject {
    @Published var isSheetPresented = false
    @Published var searchString = ""
    @Published var listCourseSemester: [CourseModel] = []
    @Published var isLoading = false
    @Published var error = ""

    func getCourseSemester(semester: Int, token: String) {
        isLoading = true
        NetworkManager.shared.callAPI2(path: "\(APIPath.getCourseSemester.stringValue)/\(semester)", method: .get, headers: ["Authorization": "Bearer \(token)"], body: nil) { (result: Result<CommonResponse<[CourseModel]>, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    switch response.status {
                    case HTTPStatusCodes.OK.rawValue:
                        self.listCourseSemester = response.data
                    default:
                        self.error = "Unexpected status code: \(response.status)"
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
