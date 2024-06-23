//
//  NewestResultView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct BlogListSearch: View {
    @Environment(\.colorScheme) var colorScheme
    var listBlog: [BlogSearchModel]
    var viewModel: SearchEntryViewModel

    var body: some View {
        ScrollView {
            if listBlog.isEmpty {
                Text("Không tìm thấy bài viết nào phù hợp !")
            } else {
                ForEach(listBlog.indices, id: \.self) { index in
                    let blog = listBlog[index]
                    NavigationLink(destination: DetailBlogView(blogId: blog._id)) {
                        VStack(alignment: .leading) {
                            WebImage(url: URL(string: blog.thumbnail_url ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(10)
                                    .frame(width: UIScreen.main.bounds.width * 0.95)

                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 5)
                                    .shimmerWithWave()
                            }

                            Text(blog.title)
                                .font(.system(size: 16, weight: .semibold))
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(.primary)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .lineLimit(2)
                                .padding(.horizontal, 5)

                            Text(blog.description)
                                .font(.system(size: 12, weight: .light))
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(.gray)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .lineLimit(3)
                                .padding(.horizontal, 5)

                            HStack(spacing: 5) {
                                ForEach(blog.tags, id: \.code) { tag in
                                    Text(tag.name)
                                        .font(.system(size: 8, weight: .bold))
                                        .foregroundStyle(Color.white)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 6)
                                        .background(Color(hex: tag.color))
                                        .cornerRadius(5)
                                }
                            }
                            .padding(.horizontal, 5)
                            .padding(.bottom, 10)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                    }
                    .onAppear {
                        // Load more content when the last item appears
                        if index == listBlog.count - 1 {
                            viewModel.loadMore(searchText: viewModel.searchString)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BlogListSearch(listBlog: [.sampleData], viewModel: SearchEntryViewModel())
}
