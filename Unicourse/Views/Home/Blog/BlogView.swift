//
//  BlogView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/6/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct BlogView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @StateObject var viewModel = BlogViewModel()
    @State private var isSearchBarVisible = false
    @State private var isLoadingFirstTime = true

    var body: some View {
        VStack {
            if viewModel.isLoadingFetchBlog {
                VStack {
                    HStack(spacing: 10) {
                        ForEach(0 ..< 3) { _ in
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 50, height: 20)
                                .cornerRadius(5)
                                .shimmerWithWave()
                        }

                        Spacer()
                    }
                    .padding(10)
                    .padding(.horizontal, 10)

                    HStack(spacing: 10) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 200, height: 40)
                            .cornerRadius(5)
                            .shimmerWithWave()

                        Spacer()
                    }
                    .padding(.horizontal, 20)

                    SkeletonBlogView()
                }
                .padding(.top, 120)
            } else {
                ScrollView {
                    TopicBlogView()
                    VStack(alignment: .leading) {
                        TopicTextView(title: "Bài viết mới nhất")
                        if !viewModel.highLightBlogs.isEmpty {
                            LatestBlogItemView(listBlog: viewModel.highLightBlogs)
                                .transition(.opacity.combined(with: .opacity))
                                .animation(.easeInOut(duration: 0.8))
                        }

                        TopicTextView(title: "Chủ đề nổi bật")
                        if !viewModel.listBlogs.isEmpty {
                            LatestBlogItemView(listBlog: viewModel.listBlogs)
                                .transition(.opacity.combined(with: .opacity))
                                .animation(.easeInOut(duration: 0.8))
                        }
                    }
                    .padding(.bottom, 20)
                }
            }

            Spacer()
        }
        .refreshable {
            Task {
                viewModel.isLoadingFetchBlog = true
                try await viewModel.getListBlog()
                try await viewModel.getHighlightBlog()
                viewModel.isLoadingFetchBlog = false
            }
        }
        .searchable(text: $viewModel.searchString, isPresented: $isSearchBarVisible, prompt: Text("Tìm kiếm"))
        .onAppear {
            if isLoadingFirstTime {
                Task {
                    viewModel.isLoadingFetchBlog = true
                    try await viewModel.getListBlog()
                    try await viewModel.getHighlightBlog()
                    viewModel.isLoadingFetchBlog = false
                    isLoadingFirstTime = false
                }
            }
        }

        .onDisappear {
            SDImageCache.shared.clearMemory()
        }
        .background {
            Color.mainBackgroundColor
                .ignoresSafeArea()
        }
        .navigationTitle("Bài viết 📰")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(Color.mainBackgroundColor, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ButtonSearchUIView(isSearchOpen: $isSearchBarVisible)
            }
        }
    }
}

#Preview {
    NavigationStack {
        BlogView()
    }
}
