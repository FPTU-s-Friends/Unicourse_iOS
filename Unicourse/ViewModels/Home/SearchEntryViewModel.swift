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
    @Published var error = ""
    @Published var isShowingAlert = false

    private let debounceSearch = CurrentValueSubject<String, Never>("")

    private var cancellables = Set<AnyCancellable>()

    init() {
        debounceSearch
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.search(searchText: searchText)
            }
            .store(in: &cancellables)
    }

    func search(searchText: String) {
        isLoading = true

        let params = ["text": searchText]

        NetworkManager.shared.callAPI2(path: APIPath.searchCourse.stringValue, method: .get, parameters: params, body: nil) {
            (result: Result<CommonResponse<SearchResponseModel>, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.listSearch = response.data

                case .failure(let error):
                    print(error)
                }
                self.isLoading = false
            }
        }
    }
}
