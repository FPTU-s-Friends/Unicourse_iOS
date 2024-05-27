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
                    VStack {
                        if let profileImageURL = appData.user?.profileImageURL,
                           let url = URL(string: profileImageURL.absoluteString)
                        {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                                    .cornerRadius(30)
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Image(.user)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                                .cornerRadius(30)
                        }
                    }
                    VStack(alignment: .leading, spacing: 7) {
                        Text("\(appData.user?.fullName ?? "Loading...")")
                            .font(.system(size: 14, weight: .semibold))

                        if let userRole = appData.user?.role {
                            switch userRole {
                            case .student:
                                roleText(TextRole.student)
                            case .lecture:
                                roleText(TextRole.lecture)
                            case .admin:
                                roleText(TextRole.admin)
                            }
                        } else {
                            roleText(TextRole.defaultValue)
                        }
                    }

                    Spacer()

                    HeaderButtonView()
                }
                .padding(.horizontal, 18)

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

                            CustomPageControlHomeView(numberOfPages: viewModel.slideData.slides.count, currentPage: $viewModel.currentPage)
                                .offset(y: 20)
                        }
                    }

                    // Danh mục kỳ semester
                    SemesterChosenView()
                        .padding(.bottom, 10)

                    // Tiến trình khoá học
                    ProgressCourseView(listEnrollCourses: viewModel.listEnrolledCourses, isLoading: $viewModel.isLoadingListEnrolled)
                        .padding(.bottom, 10)

                    // Khoá học nổi bật
                    TopCoursesView(freeCourses: viewModel.allFreeCourse, isLoadingFreeCourse: $viewModel.isLoadingAllFreeCourse)
                        .padding(.bottom, 10)

                    // Giảng viên nổi bật
                    TopLecturesView(listLectures: viewModel.listLectures)
                        .padding(.bottom, 10)

                    Spacer()
                }

                .refreshable {
                    refreshData()
                }
            }
            if viewModel.isLoadingListEnrolled {
                LoadingIndicatorView(isLoading: .constant(true))
            }
        }

        .onAppear {
            if !hasLoadedDataInitially {
                refreshData()
                hasLoadedDataInitially = true
            }
        }
        .background(Color.mainBackgroundColor)
    }

    func refreshData() {
        viewModel.getAllFreeCourse(token: appData.token)
        viewModel.fetchListEnrolledCourses(userId: appData.user?.userId ?? "", token: appData.token, isRefresh: true)
        viewModel.getUsersPaginationByRole(role: .lecture, pageSize: 10, pageNum: 1, sortBy: "lecture_info.feedback", order: .DES, token: appData.token)
    }

    func roleText(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 8, weight: .bold, design: .default))
            .foregroundStyle(Color.white)
            .padding(5)
            .background(Color.activeColor.cornerRadius(20))
    }
}

#Preview {
    HomeView()
        .environmentObject(AppData())
}
