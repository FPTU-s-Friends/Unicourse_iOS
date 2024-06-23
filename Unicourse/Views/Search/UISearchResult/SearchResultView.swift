//
//  SearchResultView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 10/5/24.
//

import SwiftUI

struct SearchResultView: View {
    @Environment(\.dismissSearch) var dismissSearch: DismissSearchAction
    @ObservedObject var viewModel: SearchEntryViewModel
    @State var tabSelection: Int = 0
    @State var isPresentedFilter = false

    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea(.all)

            VStack {
//                ResultUserView()

                TabSelectionSearchView(tabSelection: $tabSelection,
                                       selectionButtons: ["Khoá Học", "Bài Viết", "Bài Tập"])
                TabView(selection: $tabSelection) {
                    // Tab Liên quan
                    RelatedResultTabView(isLoadingSearch: $viewModel.isLoading,
                                         listSearch: $viewModel.listSearch,
                                         viewModel: viewModel)
                        .tag(0)

                    // Tab Mới nhất
                    BlogListSearch(listBlog: viewModel.listSearch.blog,
                                   viewModel: viewModel)
                        .tag(1)

                    // Tab Giảm giá
                    QuizListSearch(viewModel: viewModel,
                                   listQuiz: viewModel.listSearch.quiz)
                        .tag(2)
                }
            }
        }
        .onAppear {
            viewModel.search(searchText: viewModel.searchString)
        }

        .navigationTitle("Tìm kiếm \" \(viewModel.searchString) \"")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPresentedFilter) {
            VStack {
                Text("Filter ở đây")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        print("Save button tapped")
                        isPresentedFilter = false
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonBackUIView()
            }

            ToolbarItem(placement: .topBarTrailing) {
                ButtonCircleUIView(systemName: "ellipsis.circle.fill") {
                    isPresentedFilter.toggle()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchResultView(viewModel: SearchEntryViewModel())
    }
}
