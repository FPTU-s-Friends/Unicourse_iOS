//
//  HomeView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appData: AppData
    @StateObject var viewModel = HomeViewModel()

    // chỉ cho load data lúc đầu
    @State private var hasLoadedDataInitially = false

    var body: some View {
        ZStack {
            DailyRewardButton()
                .zIndex(1)
                .onTapGesture {
                    print("Navigate")
                }
            VStack {
                LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .topLeading, endPoint: .trailing)
                    .ignoresSafeArea(.all)
            }

            VStack {
                HStack {
                    HeaderUserView()

                    Spacer()

                    HeaderButtonView()
                }
                .padding(.horizontal, 15)
                .padding(.top, 20)

                VStack {
                    ScrollView {
                        if viewModel.isLoadingBanner {
                            VStack {
                                ProgressView()
                            }
                        } else {
                            VStack {
                                ZStack(alignment: .top) {
                                    TabView(selection: $viewModel.currentPage) {
                                        ForEach(viewModel.banners.indices, id: \.self) { index in
                                            WebImage(url: URL(string: viewModel.banners[index].img)) { img in
                                                img
                                                    .resizable()
                                                    .scaledToFit()
                                                    .cornerRadius(10)
                                                    .padding(.horizontal, 10)
                                                    .tag(index)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                        }
                                    }
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                    .frame(height: 250)
                                    .transition(.slide) // Add slide transition effect
                                    .animation(.easeInOut(duration: 1), value: viewModel.currentPage)
                                    // Add animation with easeInOut timing and duration of 0.5 seconds

                                    CustomPageControlHomeView(numberOfPages: viewModel.banners.count,
                                                              currentPage: $viewModel.currentPage)
                                        .offset(y: 20)
                                }
                            }
                            .background(Color.mainBackgroundColor)
                        }

                        // Danh mục kỳ semester
                        SemesterChosenView()
                            .padding(.bottom, 10)
                        // Khoá học nổi bật
                        TopCoursesView(isLoadingSearchCourse: $viewModel.isLoadingSearchCourse,
                                       searchCourses: viewModel.searchCourse,
                                       headerText: HeaderCategoryText.topCourseText)
                            .padding(.bottom, 10)

                        TopFreeCourseView(isLoadingSearchCourse: $viewModel.isLoadingSearchCourse,
                                          freeCourse: viewModel.listFreeCourses,
                                          headerText: HeaderCategoryText.topFreeCourse)
                            .padding(.bottom, 10)

                        // Tiến trình khoá học
                        ProgressCourseView(listEnrollCourses: viewModel.listEnrolledCourses, isLoading: $viewModel.isLoadingListEnrolled)
                            .padding(.bottom, 10)

                        // Giảng viên nổi bật
                        VStack {
                            TopLecturesView(listLectures: viewModel.listLectures)
                        }
                        .padding(.bottom, 50)

                        Spacer()
                    }
                    .background(Color.mainBackgroundColor)
                    .cornerRadius(20)
                    .refreshable {
                        Task {
                            try await fetchData()
                        }
                    }
                }
            }

            if viewModel.isLoadingListEnrolled {
                LoadingIndicatorView(isLoading: .constant(true))
                    .animation(.spring, value: viewModel.isLoadingListEnrolled)
            }
        }

        .onAppear {
            if !hasLoadedDataInitially {
                Task {
                    try await fetchData()
                    hasLoadedDataInitially = true
                }
            }
        }
    }

    func fetchData() async throws {
//        viewModel.getAllFreeCourse(token: appData.token)

        try await viewModel.getBanners()
        viewModel.search(searchText: "")
        viewModel.fetchListEnrolledCourses(userId: appData.userInfo?._id ?? "", token: appData.token, isRefresh: true)
        viewModel.getUsersPaginationByRole(role: .lecture, pageSize: 10, pageNum: 1, sortBy: "lecture_info.feedback", order: .DES, token: appData.token)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(AppData())
    }
}
