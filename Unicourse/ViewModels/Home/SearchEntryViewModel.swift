import Combine
import SwiftUI

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
                    self.listSearch = response.data
                    self.currentPage = pageToUse // Cập nhật currentPage

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
                    self.listSearch.course.append(contentsOf: response.data.course)
                    self.listSearch.quiz.append(contentsOf: response.data.quiz)
                    self.listSearch.blog.append(contentsOf: response.data.blog)
                    self.currentPage = nextPage
                case .failure(let error):
                    self.error = error.localizedDescription
                    self.isShowingAlert = true
                    print(error)
                }
                self.isLoadingMore = false
            }
        }
    }
}
