//
//  DetailBlogView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import SwiftUI

struct DetailBlogView: View {
    var blogId: String
    @StateObject var viewModel = DetailBlogViewModel()
    @State private var isShowingDescription = true
    @State private var webViewHeight: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if self.viewModel.isLoadingGetBlog {
                    ProgressView()
                } else if self.viewModel.isLoadingGetBlog == false && self.viewModel.blogDetail != nil {
                    VStack {
                        AsyncImage(url: URL(string: self.viewModel.blogDetail?.thumbnail_url ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 180)
                                .clipped()

                        } placeholder: {
                            ProgressView()
                        }

                        VStack(alignment: .leading) {
                            HStack(spacing: 18) {
                                Image(systemName: "heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 12)

                                Image(systemName: "bubble")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 12)

                                HStack(spacing: 5) {
                                    Image(systemName: "clock")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 12)

                                    Text("\(timeSinceCreated(date: self.viewModel.blogDetail?.created_at))")
                                        .font(.system(size: 12, weight: .light))
                                }
                            }
                            .padding(.top, 10)
                            .padding(.leading, 2)

                            HStack(spacing: 10) {
                                ForEach(self.viewModel.blogDetail?.tags ?? [], id: \.code) { tag in
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

                            Text(self.viewModel.blogDetail?.title ?? "")
                                .font(.system(size: 18, weight: .bold))
                                .multilineTextAlignment(.leading)

                            // Description
                            VStack {
                                HStack(spacing: 0) {
                                    Text("Description")
                                        .font(.system(size: 16, weight: .semibold))

                                    Spacer()

                                    Button {
                                        withAnimation {
                                            self.isShowingDescription.toggle()
                                        }
                                    } label: {
                                        Image(systemName: self.isShowingDescription ? "chevron.down" : "chevron.up")
                                            .resizable()
                                            .foregroundStyle(Color.mainColor1)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 14)
                                            .fontWeight(.bold)
                                    }
                                }

                                if self.isShowingDescription {
                                    Text(self.viewModel.blogDetail?.description ?? "")
                                        .font(.system(size: 14, weight: .light))
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background {
                                Color.mainColor3.cornerRadius(10)
                            }
                        }
                        .padding(.horizontal, 10)

                        VStack {
                            WebView(htmlContent: self.viewModel.blogDetail?.content ?? "", webViewHeight: self.$webViewHeight)
                                .frame(height: self.webViewHeight)
                        }
                        .padding(.horizontal, 5)

                        RelatedBlogsUIView()
                    }
                } else {
                    Text("Not Found")
                }
            }
            .onAppear {
                Task {
                    try await self.viewModel.getBlogById(blogId: self.blogId)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ButtonBackUIView()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 10) {
                        Button(action: {}, label: {
                            Image(systemName: "bookmark")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .frame(width: 10, height: 18)
                                .padding(.horizontal, 10)
                        })

                        Button(action: {}, label: {
                            Image(systemName: "globe")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .frame(width: 10, height: 18)
                                .padding(.horizontal, 10)
                        })

                        Button(action: {}, label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .frame(width: 10, height: 18)
                                .padding(.horizontal, 10)
                        })
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .background {
            Color.mainBackgroundColor.ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        DetailBlogView(blogId: "65c79810b8b576970c9246f5")
    }
}
