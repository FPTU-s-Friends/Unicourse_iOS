//
//  DetailBlogView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct DetailBlogView: View {
    var blogId: String
    @StateObject var viewModel = DetailBlogViewModel()
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var appData: AppData
    @State private var isLikeBlog: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        if viewModel.isLoadingGetBlog {
                            SkeletonBlogDetailView()
                        } else if self.viewModel.isLoadingGetBlog == false && self.viewModel.blogDetail != nil {
                            VStack {
                                AsyncImage(url: URL(string: self.viewModel.blogDetail?.thumbnail_url ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width, height: 180)
                                        .clipped()
                                    
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: geometry.size.width, height: 180)
                                        .shimmerWithWave()
                                }
                                
                                VStack(alignment: .leading) {
                                    HStack(spacing: 24) {
                                        Button {
                                            handleLike()
                                        } label: {
                                            Image(systemName: isLikeBlog ? "heart.fill" : "heart")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundStyle(Color.red.gradient)
                                                .frame(width: 14)
                                        }

                                        Button(action: {
                                            viewModel.isShowingSheetComment = true
                                        }) {
                                            Image(systemName: "bubble")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 14)
                                        }
                             
                                        HStack(spacing: 5) {
                                            Image(systemName: "clock")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundStyle(Color.green.gradient)
                                                .frame(width: 14)
                                            
                                            Text("\(timeSinceCreated(date: self.viewModel.blogDetail?.created_at))")
                                                .font(.system(size: 13, weight: .light))
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
                            NotFoundImageView(width: geometry.size.width * 0.7, height: geometry.size.height)
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            ButtonBackUIView()
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            TopTabBarButtomUIView()
                        }
                    }
                    .onAppear {
                        Task {
                            try await self.viewModel.getBlogById(blogId: self.blogId)
                            isLikeBlog = viewModel.blogDetail?.like.contains(appData.userInfo?._id ?? "") ?? false

                            try await self.viewModel.getRelatedBlog()
                        }
                    }
                }
                .frame(width: geometry.size.width)
                
                if self.viewModel.isLoadingGetBlog == false && self.viewModel.blogDetail != nil {
                    Spacer()
                    VStack {
                        BottomTabButtonUIView(isLikeBlog: isLikeBlog,
                                              actionFavorite: {
                                                  handleLike()
                                              },
                                              actionShowComment: {
                                                  viewModel.isShowingSheetComment = true
                                              })
                    }
                    .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.05)
                    .background {
                        Color.mainBackgroundColor
                    }
                }
            }
        }
        .onDisappear {
            SDImageCache.shared.clearMemory()
        }
        .sheet(isPresented: $viewModel.isShowingSheetComment, content: {
            SheetCommentView(viewModel: viewModel)
                .presentationDetents([.medium, .large])
                
        })

        .alert(isPresented: $viewModel.isShowingError) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.error),
                  dismissButton: .default(Text("OK")) {
                      viewModel.isShowingError = false
                  })
        }
        .background {
            Color.mainBackgroundColor.ignoresSafeArea()
        }
    }
    
    func handleLike() {
        if isLikeBlog {
            Task {
                do {
                    viewModel.isLoadingLike = true
                    isLikeBlog = false
                    try await viewModel.unLikeBlog(blogId: blogId, token: appData.token)
                } catch {
                    print("Error at UnLike Blog:", error)
                    viewModel.error = "UnLike blog không thành công, hãy thử lại"
                    viewModel.isShowingError = true
                    isLikeBlog = true
                }
                viewModel.isLoadingLike = false
            }
        } else {
            Task {
                do {
                    viewModel.isLoadingLike = true
                    isLikeBlog = true
                    try await viewModel.likeBlog(blogId: blogId, token: appData.token)
                } catch {
                    print("Error at UnLike Blog:", error)
                    viewModel.error = "UnLike blog không thành công, hãy thử lại"
                    viewModel.isShowingError = true
                    isLikeBlog = false
                }
                viewModel.isLoadingLike = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailBlogView(blogId: "65d542d17f0cc0de60a91059")
    }
}
