import Combine
import SwiftUI

struct SearchSuggestModel {
    let searchString: String
    let urlImage: String
}

class SearchEntryViewModel: ObservableObject {
    @Published var isNavigateToResultView = false
    @Published var searchString: String = "" {
        didSet {
            // Filter out any invalid characters
            let filteredString = searchString.filter { $0.isLetter || $0.isWhitespace }
            debounceSearch.send(filteredString)
        }
    }

    @Published var listSearch: SearchResponseModel = .init(course: [], quiz: [], blog: [])
    @Published var listSuggestCourse: [SearchSuggestModel] = []
    @Published var listFreeCourse: [SearchCourseModel] = []
//    @Published var listBlog: [BlogSearchModel] = []
//    @Published var listQuiz: [QuizSearchModel] = []
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var error = ""
    @Published var isShowingAlert = false
    @Published var currentPage = 1

    private let debounceSearch = CurrentValueSubject<String, Never>("")
    private var cancellables = Set<AnyCancellable>()

    init() {
        debounceSearch
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.currentPage = 1
                self?.search(searchText: searchText)
            }
            .store(in: &cancellables)
    }

    func search(searchText: String, page: Int? = nil, limit: Int = 6) {
        isLoading = true
        let pageToUse = page ?? currentPage

        let params: [String: Any] = ["text": searchText, "page": pageToUse, "limit": limit]

        NetworkManager.shared.callAPI2(path: APIPath.searchCourse.stringValue, method: .get, parameters: params, body: nil) {
            (result: Result<CommonResponse<SearchResponseModel>, Error>) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    if let data = response.data {
                        self.listSearch = data
                        self.listSuggestCourse = data.course.map { course in
                            SearchSuggestModel(searchString: course.title.localizedLowercase, urlImage: course.thumbnail)
                        }
//                        self.listBlog = data.blog
//                        self.listQuiz = data.quiz
                        self.filterFreeCourses()
                        self.currentPage = pageToUse
                    } else {
                        print("List search is nil")
                    }

                case .failure(let error):
                    self.error = error.localizedDescription
                    self.isShowingAlert = true
                    print(error)
                }
                self.isLoading = false
            }
        }
    }

    func loadMore(searchText: String, limit: Int = 6) {
        guard !isLoadingMore else { return }
        isLoadingMore = true

        let nextPage = currentPage + 1
        let params: [String: Any] = ["text": searchText, "page": nextPage, "limit": limit]

        NetworkManager.shared.callAPI2(path: APIPath.searchCourse.stringValue, method: .get, parameters: params, body: nil) {
            (result: Result<CommonResponse<SearchResponseModel>, Error>) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    if let data = response.data {
                        self.listSearch.course.append(contentsOf: data.course)
                        self.listSearch.quiz.append(contentsOf: data.quiz)
                        self.listSearch.blog.append(contentsOf: data.blog)
                        self.filterFreeCourses()
                        self.currentPage = nextPage
                    } else {
                        print("Load more data is nil")
                    }

                case .failure(let error):
                    self.error = error.localizedDescription
                    self.isShowingAlert = true
                    print(error)
                }
                self.isLoadingMore = false
            }
        }
    }

    private func filterFreeCourses() {
        listFreeCourse = listSearch.course.filter { $0.type == .free }.map { course in
            SearchCourseModel(_id: course._id, title: course.title, titleDescription: course.titleDescription, enrollmentCount: course.enrollmentCount, type: course.type, amount: course.amount, thumbnail: course.thumbnail, lecture: course.lecture)
        }
    }
}
