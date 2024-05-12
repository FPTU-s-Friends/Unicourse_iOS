//
//  HomeView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct HomeView: View {
    @State private var currentPage = 0
    @EnvironmentObject var appData: AppData

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
                                .font(.system(size: 14, weight: .bold, design: .default))

                            Text("Học Sinh")
                                .font(.system(size: 12, weight: .bold, design: .default))
                                .foregroundStyle(Color.white)
                                .padding(5)
                                .background(Color.activeColor.cornerRadius(20))
                        }

                        Spacer()

                        HeaderButtonView()
                    }
                    .padding(.horizontal, 18)

                    VStack {
                        ZStack(alignment: .top) {
                            TabView(selection: $currentPage) {
                                Image("MainBanner")
                                    .resizable()
                                    .scaledToFit()
                                Image("MainBanner")
                                    .resizable()
                                    .scaledToFit()
                                Image("MainBanner")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(height: 200)

                            CustomPageControlHomeView(numberOfPages: 3, currentPage: $currentPage)
                                .padding(.top, 15)
                        }
                    }
                    .padding()

                    // Danh mục kỳ semester
                    SemesterChosenView()
                        .padding(.bottom, 10)

                    // Tiến trình khoá học
                    ProgressCourseView()
                        .padding(.bottom, 10)

                    // Khoá học nổi bật
                    TopCoursesView()
                        .padding(.bottom, 10)

                    // Giảng viên nổi bật
                    TopLecturesView()
                        .padding(.bottom, 10)

                    Spacer()
                }
            }
        }
        .background(Color.mainBackgroundColor)
    }
}

#Preview {
    HomeView()
        .environmentObject(AppData())
}
