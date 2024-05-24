//
//  SearchEntryView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 9/5/24.
//

import SwiftUI

struct SearchEntryView: View {
    @StateObject var viewModel = SearchEntryViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 5) {
            // Search Field
            SearchFieldView(
                searchString: $viewModel.searchString,
                action: { dismiss() },
                isFilterIconHidden: $viewModel.isFilterIconHidden,
                isNavigateToResultView: $viewModel.isNavigateToResultView
            )

            // Search Matching
            SearchSuggestTextView(searchText: $viewModel.searchString)

//            Suggest Course
            SuggestCourseView(listSearchCourse: viewModel.listSearchCourse)
        }
        .padding(10)
        .background(Color.mainBackgroundColor)
        .navigationDestination(isPresented: $viewModel.isNavigateToResultView) {
            SearchResultView(
                searchString: $viewModel.searchString,
                isFilterIconHidden: $viewModel.isFilterIconHidden,
                isNavigateToResultView: $viewModel.isNavigateToResultView
            )
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        SearchEntryView()
    }
}
