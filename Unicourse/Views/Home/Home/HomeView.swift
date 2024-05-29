//
//  HomeView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appData: AppData
    @StateObject var viewModel = HomeViewModel()

    // chỉ cho load data lúc đầu
    @State private var hasLoadedDataInitially = false

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    HeaderUserView()
                        .padding(.horizontal, 10)

                    Spacer()

                    HeaderButtonView()
                        .padding(.horizontal, 10)
                }
                ScrollView {
                    VStack {
                        ZStack(alignment: .top) {
                            TabView(selection: $viewModel.currentPage) {
                                ForEach(viewModel.slideData.slides.indices, id: \.self) { index in
                                    Image(viewModel.slideData.slides[index].imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(10)
                                        .padding(.horizontal, 10)
                                        .tag(index)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(height: 250)
                            .transition(.slide) // Add slide transition effect
                            .animation(.easeInOut(duration: 1), value: viewModel.currentPage)
                            // Add animation with easeInOut timing and duration of 0.5 seconds

                            CustomPageControlHomeView(numberOfPages: viewModel.slideData.slides.count, currentPage: $viewModel.currentPage)
                                .offset(y: 20)
                        }
                    }
                    .background(Color.mainBackgroundColor)

                    // Danh mục kỳ semester
                    SemesterChosenView()
                        .padding(.bottom, 10)
                    // Khoá học nổi bật
                    TopCoursesView(isLoadingSearchCourse: $viewModel.isLoadingSearchCourse, searchCourses: viewModel.searchCourse, headerText: HeaderCategoryText.topCourseText)
                        .padding(.bottom, 10)

                    TopCoursesView(isLoadingSearchCourse: $viewModel.isLoadingSearchCourse, searchCourses: viewModel.listFreeCourses, headerText: HeaderCategoryText.topFreeCourse)
                        .padding(.bottom, 10)

                    // Tiến trình khoá học
                    ProgressCourseView(listEnrollCourses: viewModel.listEnrolledCourses, isLoading: $viewModel.isLoadingListEnrolled)
                        .padding(.bottom, 10)

                    // Giảng viên nổi bật
                    TopLecturesView(listLectures: viewModel.listLectures)
                        .padding(.bottom, 10)

                    Spacer()
                }

                .refreshable {
                    fetchData()
                }
            }
            if viewModel.isLoadingListEnrolled {
                LoadingIndicatorView(isLoading: .constant(true))
            }
        }

        .onAppear {
            if !hasLoadedDataInitially {
                fetchData()
                hasLoadedDataInitially = true
            }
        }
        .background(Color.mainBackgroundColor)
    }

    func fetchData() {
//        viewModel.getAllFreeCourse(token: appData.token)

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
