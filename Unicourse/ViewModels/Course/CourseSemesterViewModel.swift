//
//  CourseSemesterViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import Combine
import Foundation

class CourseSemesterViewModel: ObservableObject {
    @Published var isSheetPresented = false
    @Published var searchString = ""
    @Published var listCourseSemester: [CourseModel] = []
    @Published var isLoading = false
    @Published var error = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        // Debounce search string
        $searchString
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.filterCourses()
            }
            .store(in: &cancellables)
    }

    var filteredCourseSemester: [CourseModel] = []

    func filterCourses() {
        if searchString.isEmpty {
            filteredCourseSemester = listCourseSemester
        } else {
            filteredCourseSemester = listCourseSemester.filter { $0.title.lowercased().contains(searchString.lowercased()) }
        }
    }

    func getCourseSemester(semester: Int, token: String) {
        isLoading = true
        NetworkManager.shared.callAPI2(path: "\(APIPath.getCourseSemester.stringValue)/\(semester)", method: .get, headers: ["Authorization": "Bearer \(token)"], body: nil) { (result: Result<CommonResponse<[CourseModel]>, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    switch response.status {
                    case HTTPStatusCodes.OK.rawValue:
                        if let data = response.data {
                            self.listCourseSemester = data
                        } else {
                            self.listCourseSemester = []
                        }

                        self.filterCourses()
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
