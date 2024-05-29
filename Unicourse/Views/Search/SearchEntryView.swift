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
    @Environment(\.dismiss) var dismiss: DismissAction
    var body: some View {
        VStack(spacing: 5) {
            ScrollView(showsIndicators: false) {
                VStack {
                    // Search Matching
                    SearchSuggestTextView(viewModel: viewModel)

                    //            Suggest Course
                    SuggestCourseView(listSearch: $viewModel.listSearch,
                                      isLoadingSearch: $viewModel.isLoading)
                }
                .navigationBarBackButtonHidden(true)
                .navigationTitle("Tìm kiếm khoá học")
                .navigationBarTitleDisplayMode(.automatic)
                .searchable(text: $viewModel.searchString,
                            prompt: Text("Tìm Khoá Học"))
                .onSubmit(of: .search) {
                    viewModel.isNavigateToResultView = true
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                })
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    HStack(spacing: 8) {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                    }
                    .padding(8)
                    .background(.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .inset(by: 0.25)
                            .stroke(Color(red: 0.26, green: 0.52, blue: 0.96), lineWidth: 0.25)
                    )
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
