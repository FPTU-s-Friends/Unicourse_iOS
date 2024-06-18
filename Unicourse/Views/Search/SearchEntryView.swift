//
//  SearchEntryView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 9/5/24.
//

import SwiftUI

struct SearchEntryView: View {
    @StateObject var viewModel = SearchEntryViewModel()
    @State private var isLoadingFirstTime = false

    var body: some View {
        VStack(spacing: 5) {
            ScrollView(showsIndicators: false) {
                VStack {
//                    // Search Matching
//                    SearchSuggestTextView(viewModel: viewModel)
                    //            Suggest Course
                    SuggestCourseView(listSearch: $viewModel.listSearch,
                                      isLoadingSearch: $viewModel.isLoading)
                }
                .navigationBarBackButtonHidden(true)
                .navigationTitle("Tìm kiếm khoá học")
                .navigationBarTitleDisplayMode(.large)
                .searchable(text: $viewModel.searchString, placement: .navigationBarDrawer(displayMode: .always),
                            prompt: Text("Tìm Khoá Học"))

                .onSubmit(of: .search) {
                    viewModel.isNavigateToResultView = true
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonBackUIView()
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    HStack(spacing: 8) {
                        Image(systemName: "ellipsis.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34)
                            .foregroundStyle(
                                Color.white,
                                Color.mainColor1.gradient
                            )
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 0.1)
                            )
                            .padding(3)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }

                })
            }
        }

        .padding(10)
        .background(Color.mainBackgroundColor)
        .navigationDestination(isPresented: $viewModel.isNavigateToResultView) {
            SearchResultView(viewModel: viewModel)
                .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            if !isLoadingFirstTime {
                viewModel.search(searchText: "")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchEntryView()
    }
}
