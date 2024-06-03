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
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        GeometryReader { geometry in
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
                                    .frame(width: geometry.size.width, height: 180)
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
                                        Text("Miêu tả")
                                            .font(.system(size: 16, weight: .semibold))
                                        
                                        Spacer()
                                        
                                        Button {
                                            withAnimation {
                                                viewModel.isShowingDescription.toggle()
                                            }
                                        } label: {
                                            Image(systemName: viewModel.isShowingDescription ? "chevron.down" : "chevron.up")
                                                .resizable()
                                                .foregroundStyle(Color.mainColor1)
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 14)
                                                .fontWeight(.bold)
                                        }
                                    }
                                    
                                    if viewModel.isShowingDescription {
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
                                WebView(htmlContent: viewModel.blogDetail?.content ?? "", webViewHeight: $viewModel.webViewHeight)
                                    .frame(height: viewModel.webViewHeight)
                                    .frame(width: geometry.size.width * 0.95)
                            }
                           
                            RelatedBlogsUIView(listRelatedBlog: viewModel.listRelatedBlog)
                        }
                    } else {
                        Text("Not Found")
                    }
                }
                .onAppear {
                    Task {
                        try await self.viewModel.getBlogById(blogId: self.blogId)
                        try await self.viewModel.getRelatedBlog()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        ButtonBackUIView()
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        TopTabBarButtomUIView()
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        BottomTabButtonUIView(actionFavorite: {},
                                              actionShowComment: {
                                                  viewModel.isShowingSheetComment = true
                                              })
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
            .frame(width: geometry.size.width)
        }

        .sheet(isPresented: $viewModel.isShowingSheetComment, content: {
            ZStack {
                Color.mainColor3
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Hiện comment ở đây")
                }
            }
            .presentationDetents([.medium, .large])

        })
        .alert(isPresented: $viewModel.isShowingError) {
            Alert(title: Text("Lỗi khi lấy blog"),
                  message: Text(viewModel.error),
                  dismissButton: .default(Text("OK")) {
                      viewModel.isShowingError = false
                  })
        }
        .background {
            Color.mainBackgroundColor.ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        DetailBlogView(blogId: "65d542d17f0cc0de60a91059")
    }
}
