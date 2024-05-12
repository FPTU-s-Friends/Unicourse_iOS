//
//  OnBoardView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/5/24.
//

import SwiftUI

struct OnBoardView: View {
    @StateObject var viewModel = OnboardViewModel()
    private let pages: [OnboardModel] = OnboardModel.pageBanners
    private let dotAppearance = UIPageControl.appearance()

    var body: some View {
        VStack {
            TabView(selection: $viewModel.pageIndex,
                    content: {
                        ForEach(pages) { page in
                            VStack {
                                PageView(page: page)
                            }
                            .tag(page.tag)
                            .padding(.bottom, 10)
                        }
                    })
            if viewModel.pageIndex == pages.count - 1 {
                Button(action: {
                    viewModel.navigateToLogin = true
                }) {
                    Text("Đăng nhập")
                        .fontWeight(.bold)
                        .frame(width: 300, height: 60)
                        .foregroundColor(.white)
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.mainColor1, Color.mainColor2]), startPoint: .leading, endPoint: .bottom)
                )
                .cornerRadius(10)
            } else {
                ButtonMain(action: { incrementPage() }, text: "Tiếp tục")
            }
        }
        .animation(.easeInOut, value: viewModel.pageIndex)
        .tabViewStyle(.page)
        .onAppear {
            let activeDotImage = UIImage(named: "activeDot")
            dotAppearance.setCurrentPageIndicatorImage(activeDotImage, forPage: 0)
            dotAppearance.setCurrentPageIndicatorImage(activeDotImage, forPage: 1)
            dotAppearance.setCurrentPageIndicatorImage(activeDotImage, forPage: 2)
            dotAppearance.currentPageIndicatorTintColor = UIColor(.mainColor1)
            dotAppearance.pageIndicatorTintColor = UIColor(Color(hex: "BEBFC2"))
        }
        .background(LinearGradient(colors: [Color.mainColor1, .white], startPoint: .leading, endPoint: .bottom))
        .fullScreenCover(isPresented: $viewModel.navigateToLogin) {
            LoginView()
        }
    }

    func incrementPage() {
        if viewModel.pageIndex < pages.count {
            viewModel.pageIndex += 1
        } else {
            viewModel.navigateToLogin = true
            viewModel.pageIndex = 0
        }
    }
}

#Preview {
    OnBoardView()
}
