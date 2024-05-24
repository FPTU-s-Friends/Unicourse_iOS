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
    var courseDetail: CourseModel

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(Color.mainBackgroundColor)
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 16) {
                    // Go Back Button - Favorite Button - Share Button
                    VStack {
                        AsyncImage(url: URL(string: courseDetail.thumbnail)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(24)

                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#DAE9DA"))
                    .clipShape(RoundedRectangle(cornerRadius: 24.0))
                    // Go Back Button - Favorite Button - Share Button

                    // Basic info
                    BasicInfo(courseName: courseDetail.title, courseAvgRating: 4.3, courseTotalRatingCount: 300, memberCount: 398, isLoading: vm.isLoading)
                    // End basic info

                    // Tab bar
                    VStack {
                        TabSelectionView(tabSelection: $tabSelection)
                        TabView(selection: $tabSelection) {
                            CourseDetailTabView(courseLectureName: courseDetail.lecture?.fullName ?? DefaultTextUser.defaultNameLecture,
                                                lectureDescription: courseDetail.lecture?.lecture_info?.description ?? "",
                                                imageLectureURL: courseDetail.lecture?.profile_image ?? DefaultURL.defaultUserURL,
                                                isLoading: vm.isLoading).tag(0)

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

//            if vm.isLoading {
//                LoadingIndicatorView(isLoading: .constant(true))
//            }
        }
//        .onAppear {
//            vm.fetchCourseDetailById(courseId: courseId)
//        }
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
        CourseDetailView(courseDetail: CourseModel.sampleData)
            .environmentObject(AppData())
    }
}
