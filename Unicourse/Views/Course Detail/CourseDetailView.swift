//
//  CourseDetailView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 9/5/24.
//

import SwiftUI

struct CourseDetailView: View {
    var courseId: String
    @EnvironmentObject var appData: AppData
    @State private var isFav: Bool = false
    @State private var tabSelection = 0
    @StateObject private var vm = CourseDetailViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(Color.mainBackgroundColor)
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 16) {
                    // Go Back Button - Favourite Button - Share Button
                    VStack {
                        Image("3diconsiconcourse")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 237, height: 237)
                        Spacer()
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#DAE9DA"))
                    .clipShape(RoundedRectangle(cornerRadius: 24.0))
                    // Go Back Button - Favourite Button - Share Button

                    // Basic info
                    BasicInfo(courseName: vm.courseDetail?.title ?? "", courseAvgRating: 4.3, courseTotalRatingCount: 300, memberCount: 398, isLoading: vm.isLoading)
                    // End basic info

                    // Tab bar
                    VStack {
                        TabSelectionView(tabSelection: $tabSelection)
                        TabView(selection: $tabSelection) {
                            CourseDetailTabView(courseLectureName: vm.courseDetail?.lecture?.fullName ?? "", lectureDescription: vm.courseDetail?.lecture?.lecture_info?.description ?? "Loading..", imageLectureURL: (vm.courseDetail?.lecture?.profile_image) ?? "", isLoading: vm.isLoading).tag(0)

                            CourseSyllabusTabView().tag(1)

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

            VStack {
                NavigationLink {
                    CourseVideoPlayerView()
                } label: {
                    ButtonGradientUI(titleButton: "Bắt đầu học")
                }
            }
            .padding(.horizontal, 20)
            .background(.white)

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
                            CircleButtonUI(isActive: isFav, systemName: "cart", symbolRenderingMode: .multicolor)
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
                        CircleButtonUI(isActive: false, systemName: "arrowshape.turn.up.right", symbolRenderingMode: .multicolor)
                    }).tint(.black)
                }
            }
        }
    }
}

// #Preview {
//    NavigationStack {
//        CourseDetailView()
//            .environmentObject(AppData())
//    }
// }
