//
//  SearchEntryViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 10/5/24.
//

import Foundation

class SearchEntryViewModel: ObservableObject {
    @Published var isFilterIconHidden = false
    @Published var isNavigateToResultView = false
    @Published var searchString: String = ""
}
