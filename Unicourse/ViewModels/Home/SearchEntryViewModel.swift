import Combine
import SwiftUI

class SearchEntryViewModel: ObservableObject {
    @Published var isFilterIconHidden = false
    @Published var isNavigateToResultView = false
    @Published var searchString: String = "" {
        didSet {
            // Filter out any invalid characters
            let filteredString = searchString.filter { $0.isLetter || $0.isWhitespace }
            debounceSearch.send(filteredString)
        }
    }

    @Published var listSearchCourse: [SearchCourseModel] = []
    @Published var isLoading = false
    @Published var error = ""
    @Published var isShowingAlert = false

    private let debounceSearch = CurrentValueSubject<String, Never>("")

    private var cancellables = Set<AnyCancellable>()

    init() {
        debounceSearch
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.searchCourse(searchText: searchText)
            }
            .store(in: &cancellables)
    }

    func searchCourse(searchText: String) {
        guard !searchText.isEmpty else {
            listSearchCourse = []
            return
        }

        isLoading = true

        print("\(APIPath.searchCourse.stringValue)?text=\(searchText)")

        NetworkManager.shared.callAPI2(path: "\(APIPath.searchCourse.stringValue)?text=\(searchText)", method: .get, body: nil) {
            (result: Result<CommonResponse<SearchCourseResponseModel>, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    printJSONData(data: response.data)
                    if response.data.course.isEmpty {
                        self.listSearchCourse = []
                    } else {
                        self.listSearchCourse = response.data.course
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.isLoading = false
            }
        }
    }
}
