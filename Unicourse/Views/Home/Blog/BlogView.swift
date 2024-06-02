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

    var body: some View {
        VStack {
            ScrollView {
                TopicBlogView()
                VStack(alignment: .leading) {
                    TopicTextView(title: "Bài viết mới nhất")
                    if !viewModel.highLightBlogs.isEmpty {
                        LatestBlogItemView(listBlog: viewModel.highLightBlogs)
                    }

                    TopicTextView(title: "Chủ đề nổi bật")
                    if !viewModel.listBlogs.isEmpty {
                        LatestBlogItemView(listBlog: viewModel.listBlogs)
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchString, isPresented: $isSearchBarVisible, prompt: Text("Tìm kiếm"))
        .onAppear {
            Task {
                try await viewModel.getListBlog()
                try await viewModel.getHighlightBlog()
            }
        }

        .onDisappear {
            SDImageCache.shared.clearMemory()
        }
        .background {
            Color.mainBackgroundColor
                .ignoresSafeArea()
        }
        .navigationTitle("Bài viết")
        .navigationBarTitleDisplayMode(.inline)
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
