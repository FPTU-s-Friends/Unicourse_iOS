//
//  HomeViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 22/5/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published var banners: [BannerModel] = []
    @Published var searchCourse: [SearchCourseModel] = []
    @Published var isLoadingListEnrolled = false
    @Published var isLoadingSearchCourse = false
    @Published var isLoadingGetUser = false
    @Published var isLoadingBanner = false
    @Published var isShowingAlert = false
    @Published var error = ""
    @Published var listEnrolledCourses: [EnrolledCourseModel] = []
    @Published var listLectures: [LectureModel] = []
    var listFreeCourses: [SearchCourseModel] {
        searchCourse.filter {
            $0.type == CourseEnrollType.free
        }
    }
    
    private var hasFetched: Bool = false
    
    func search(searchText: String, page: Int? = 1, limit: Int = 6) {
        isLoadingSearchCourse = true
        let pageToUse = page ?? currentPage
        
        let params: [String: Any] = ["text": searchText, "page": pageToUse, "limit": limit]
        
        NetworkManager.shared.callAPI2(path: APIPath.searchCourse.stringValue, method: .get, parameters: params, body: nil) {
            (result: Result<CommonResponse<SearchResponseModel>, Error>) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                    case .success(let response):
                        if let data = response.data {
                            self.searchCourse = data.course
                            self.currentPage = pageToUse
                        } else {
                            print("Search home view data is nil")
                        }
                        
                    case .failure(let error):
                        self.error = error.localizedDescription
                        self.isShowingAlert = true
                        print(error)
                }
                self.isLoadingSearchCourse = false
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
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        switch response.status {
                            case HTTPStatusCodes.OK.rawValue:
                                if let data = response.data {
                                    self.listEnrolledCourses = data
                                }
                               
                                self.hasFetched = true
                            default:
                                self.error = "Unexpected status code: \(response.status)"
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    switch result {
                        case .success(let response):
                            switch response.status {
                                case HTTPStatusCodes.OK.rawValue:
                                    if let data = response.data {
                                        self.listEnrolledCourses = data
                                    }
                                    
                                    self.hasFetched = true
                                default:
                                    self.error = "Unexpected status code: \(response.status)"
                            }
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                    }
                }
                self.isLoadingListEnrolled = false
            }
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
                                    if let data = response.data {
                                        self.listLectures = data.data
                                    }
                                   
                                default:
                                    self.error = "Unexpected status code: \(response.status)"
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            print(error.localizedDescription)
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
    
    func getBanners() async throws {
        let path = APIPath.getBanners.stringValue
        let method = HTTPMethod.get
       
        do {
            isLoadingBanner = true
            let response: CommonResponse<[BannerModel]> = try await NetworkManager.shared.callAPI(path: path, method: method, body: nil)
            if let data = response.data {
                banners = data
            }
            
        } catch {
            self.error = "Không lấy được dữ liệu banner"
            isShowingAlert = true
        }
        isLoadingBanner = false
    }
}

//    func getAllFreeCourse(token: String) {
//        isLoadingAllFreeCourse = true
//        NetworkManager.shared.callAPI2(path: APIPath.getAllFreeCourse.stringValue, method: .get, headers: ["Authorization": "Bearer \(token)"], body: nil) { (result: Result<CommonResponse<[CourseModel]>, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let response):
//                    switch response.status {
//                    case HTTPStatusCodes.OK.rawValue:
//                        printJSONData(data: response)
//                        self.allFreeCourse = response.data
//                    default:
//                        self.error = "Unexpected status code: \(response.status)"
//                    }
//
//                case .failure(let error):
//                    print(error)
//                    self.error = error.localizedDescription
//                }
//                self.isLoadingAllFreeCourse = false
//            }
//        }
//    }
