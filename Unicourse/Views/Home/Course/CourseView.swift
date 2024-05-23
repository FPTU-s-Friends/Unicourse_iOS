//
//  CourseView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct CourseView: View {
    @State private var mockUserId: String = "6646f84216457d365c09d6d6"
    @EnvironmentObject private var appData: AppData
    @StateObject private var vm = CourseViewModel()
    @State private var textSearch: String = ""
    @State private var showingCredits = false

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.mainBackgroundColor)
                .ignoresSafeArea()

            VStack(spacing: 10) {
                VStack {
                    VStack {
                        // Header Cards
                        HStack {
                            Text("Khoá học của tôi")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.white)
                            Spacer()

                            HeaderButtonView()
                        }
                        .frame(height: 50)
                        // End Header card

                        // Tracking course card
                        if vm.listEnrolledCourses.isEmpty {
                            SkeletonTrackingCourseView()
                        } else {
                            TrackingCourseCard(enrollCourse: vm.listEnrolledCourses[0])
                        }

                        // End tracking course card
                    }
                    .padding([.horizontal, .bottom], 18)
                    .safeAreaPadding(.top, 59)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.37, green: 0.87, blue: 0.96), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.62, green: 0.5, blue: 0.97), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .cornerRadius(24)

                    // Current  learning  course
                    CurrentLearningCourses(showingCredits: $showingCredits, listEnrolledCourses: vm.listEnrolledCourses)
                        .refreshable {
                            vm.fetchListEnrolledCourses(userId: appData.user?.userId ?? mockUserId, token: appData.token, isRefresh: true)
                        }
                }
            }

            .ignoresSafeArea()

            if vm.isLoading {
                LoadingIndicatorView(isLoading: .constant(true))
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                vm.fetchListEnrolledCourses(userId: appData.user?.userId ?? mockUserId, token: appData.token, isRefresh: false)
            }
        }
    }
}

#Preview {
    CourseView()
        .environmentObject(AppData())
}
