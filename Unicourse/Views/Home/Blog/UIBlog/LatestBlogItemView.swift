//
//  LastestBlogItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/6/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct LatestBlogItemView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var listBlog: [BlogModel]

    var body: some View {
        NavigationLink(destination: DetailBlogView(blogId: listBlog[0]._id)) {
            VStack(alignment: .leading) {
                WebImage(url: URL(string: listBlog[0].thumbnail_url)) { image in
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

                Text(listBlog[0].title)
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.primary)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .lineLimit(2)
                    .padding(.horizontal, 5)

                VStack {
                    HStack(spacing: 5) {
                        AsyncImage(url: URL(string: listBlog[0].userId.profile_image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .cornerRadius(20)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(listBlog[0].userId.fullName)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color.gray)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                    }

                    HStack(spacing: 5) {
                        ForEach(listBlog[0].tags, id: \.code) { tag in
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
            }
            .background(.white)
            .cornerRadius(10)
            .padding(.horizontal, 10)
        }
        .transition(.opacity.combined(with: .opacity))
        .animation(.easeInOut(duration: 0.8))

        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 180), spacing: 10)], spacing: 10) {
                ForEach(listBlog.dropFirst(), id: \._id) { blog in
                    NavigationLink(destination: DetailBlogView(blogId: blog._id)) {
                        VStack(alignment: .leading) {
                            WebImage(url: URL(string: blog.thumbnail_url)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(10)
                                    .frame(width: UIScreen.main.bounds.width * 0.45)
                            } placeholder: {
                                ProgressView()
                            }

                            Text(blog.title)
                                .font(.system(size: 10, weight: .semibold))
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .lineLimit(2)
                                .padding(.horizontal, 5)
                                .padding(.top, 10)

                            VStack(alignment: .leading) {
                                HStack(spacing: 5) {
                                    WebImage(url: URL(string: blog.userId.profile_image)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 20, height: 20)
                                            .cornerRadius(16)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text(blog.userId.fullName)
                                        .font(.system(size: 8, weight: .regular))
                                        .foregroundStyle(Color.gray)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)

                                    Spacer()
                                }
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
                            }
                            .padding(.horizontal, 5)
                            .padding(.bottom, 10)
                        }
                        .background(.white)
                        .cornerRadius(10)
                    }
                }
            }
        }
        .transition(.opacity.combined(with: .opacity))
        .animation(.easeInOut(duration: 0.8))
        .padding(.horizontal, 10)
    }
}

#Preview {
    LatestBlogItemView(listBlog: [BlogModel.sampleBlogModel, BlogModel.sampleBlogModel])
}
