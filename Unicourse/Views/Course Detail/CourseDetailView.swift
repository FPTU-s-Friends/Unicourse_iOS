//
//  CourseDetailView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 9/5/24.
//

import SwiftUI

struct CourseDetailView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = CourseDetailViewModel()
    @State private var isFav: Bool = false
    @State private var tabSelection = 0
    var courseId: String

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(Color.mainBackgroundColor)
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 16) {
                    // Go Back Button -   Favorite Button - Share Button
                    VStack {
                        if let url = URL(string: vm.courseDetail?.thumbnail ?? "default") {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                                    .cornerRadius(24)

                            } placeholder: {
                                RoundedRectangle(cornerRadius: 24.0)
                                    .frame(height: 200)
                                    .foregroundStyle(Color.gray.opacity(0.5))
                            }
                        } else {
                            RoundedRectangle(cornerRadius: 24)
                                .frame(height: 200)
                                .foregroundStyle(Color.gray.opacity(0.5))
                        }
                    }
                    .cornerRadius(24)
                    // Go Back Button - Favorite Button - Share Button

                    // Basic info
                    BasicInfo(courseName: vm.courseDetail?.title ?? DefaultTextUser.defaultNameLecture, courseAvgRating: 4.3, courseTotalRatingCount: 300, memberCount: vm.courseDetail?.enrollmentCount ?? -1, isLoading: vm.isLoading)
                    // End basic info

                    // Tab bar
                    VStack {
                        TabSelectionView(tabSelection: $tabSelection, selectionButtons: ["Chi tiết", "Lộ trình", "Đánh giá"])
                        TabView(selection: $tabSelection) {
                            CourseDetailTabView(courseLectureName: vm.courseDetail?.lecture?.fullName ?? DefaultTextUser.defaultNameLecture,
                                                lectureDescription: vm.courseDetail?.lecture?.lecture_info?.description ?? "",
                                                imageLectureURL: vm.courseDetail?.lecture?.profile_image ?? DefaultURL.defaultUserURL,
                                                isLoading: vm.isLoading,
                                                subTitleDescription: vm.courseDetail?.subTitleDescription ?? [],
                                                subTitle: vm.courseDetail?.subTitle ?? "",
                                                courseName: vm.courseDetail?.title ?? "").tag(0)

                            CourseSyllabusTabView(listTrack: vm.courseDetail?.tracks ?? []).tag(1)

                            CourseReviewTabView().tag(2)
                        }
                        .frame(height: 400)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .padding(.bottom, 70)
                    }

                    // Main View
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 18)

            // Check is enrolled
            VStack {
                NavigationLink {
                    CourseVideoPlayerView(listTrack: vm.courseDetail?.tracks ?? [], title: vm.courseDetail?.title ?? "")
                        .navigationBarBackButtonHidden(true)
                } label: {
                    ButtonGradientUI(titleButton: "Bắt đầu học")
                }
            }
            .padding(.horizontal, 20)
            .background(.white)
            // End Check is enrolled

            if vm.isLoading {
                LoadingIndicatorView(isLoading: .constant(true))
            }
        }
        .onAppear {
            vm.fetchCourseDetailById(courseId: courseId)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    CircleButtonUI(isActive: false, systemName: "arrow.left", symbolRenderingMode: .multicolor)
                }).tint(.black)
            }

            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button(action: {
                        isFav.toggle()
                    }, label: {
                        CircleButtonUI(isActive: isFav, systemName: "heart", symbolRenderingMode: .multicolor)
                    }).tint(.black)

                    NavigationLink(destination: CartView()) {
                        ZStack {
                            CircleButtonUI(isActive: true, systemName: "cart", symbolRenderingMode: .multicolor)
                                .tint(.black)
                            Text("12")
                                .font(.system(size: 10))
                                .foregroundStyle(.white)
                                .padding(2)
                                .background(Color.activeColor.cornerRadius(20))
                                .padding(.leading, 20)
                                .padding(.bottom, 20)
                        }
                    }

                    Button(action: {}, label: {
                        CircleButtonUI(isActive: true, systemName: "arrowshape.turn.up.right", symbolRenderingMode: .multicolor)
                    }).tint(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CourseDetailView(courseId: "65a8790ba30979a347d026c9")
            .environmentObject(AppData())
    }
}
