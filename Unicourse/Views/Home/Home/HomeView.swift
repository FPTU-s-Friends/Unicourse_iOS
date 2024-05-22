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

    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    HStack {
                        Image("User")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)

                        VStack(alignment: .leading, spacing: 7) {
                            Text("\(appData.user?.fullName ?? "Loading...")")
                                .font(.system(size: 14, weight: .semibold))

                            if let userRole = appData.user?.role {
                                switch userRole {
                                case .student:
                                    roleText("Học Viên")
                                case .teacher:
                                    roleText("Giảng Viên")
                                case .admin:
                                    roleText("Admin")
                                }
                            } else {
                                Text("Unknown")
                            }
                        }

                        Spacer()

                        HeaderButtonView()
                    }
                    .padding(.horizontal, 18)

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
                    ProgressCourseView(listEnrollCourses: viewModel.listEnrolledCourses)
                        .padding(.bottom, 10)

                    // Khoá học nổi bật
                    TopCoursesView(freeCourse: viewModel.allFreeCourse)
                        .padding(.bottom, 10)

                    // Giảng viên nổi bật
                    TopLecturesView()
                        .padding(.bottom, 10)

                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.getAllFreeCourse(token: appData.token)
            viewModel.fetchListEnrolledCourses(userId: appData.user?.userId ?? "Bố mày", token: appData.token, isRefresh: false)
        }
        .background(Color.mainBackgroundColor)
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
