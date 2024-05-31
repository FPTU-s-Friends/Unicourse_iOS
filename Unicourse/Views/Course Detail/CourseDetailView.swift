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
    @State private var isAddToCart = false
    @State private var isShowSuccess: Bool = false
    @State private var confirmEnrollFreeCourse: Bool = false
    private var isFree: Bool {
        vm.courseDetail?.type == .free
    }

    var courseId: String

    var isEnrolled: Bool {
        if appData.userInfo?.enrollCourses?.contains(where: { course_enrolled in
            course_enrolled.courseId._id == courseId
        }) ?? false || appData.listCurrentEnrolled.contains(courseId) {
            return true
        }
        return false
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(Color.mainBackgroundColor)
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 16) {
                    // Go Back Button -     Favorite Button - Share Button
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
                    BasicInfo(courseName: vm.courseDetail?.title ?? DefaultTextUser.defaultNameLecture, courseAvgRating: 4.3, courseTotalRatingCount: 300, memberCount: vm.courseDetail?.enrollmentCount ?? -1, isLoading: vm.isLoading, courseType: vm.courseDetail?.type ?? .free)
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
                                                courseName: vm.courseDetail?.title ?? "",
                                                lecture_id: vm.courseDetail?.lecture?._id ?? "").tag(0)

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

            if isEnrolled {
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

            } else {
                HStack(alignment: .center) {
                    AddToCartButton {
                        if isFree {
                            isAddToCart.toggle()
                        } else {
                            print("Khoá trả phí")
                        }
                    }
                    .alert(isPresented: $isAddToCart) {
                        Alert(title: Text("Khoá miễn phí"), dismissButton: .default(Text("Đồng ý")))
                    }
                    if isFree {
                        Button {
                            confirmEnrollFreeCourse.toggle()
                        } label: {
                            ButtonGradientUI(titleButton: "Tham gia ngay")
                        }
                        .alert(isPresented: $confirmEnrollFreeCourse) {
                            Alert(title: Text("Bạn có chắc chắn tham gia ?"), primaryButton: .default(Text("Tham gia")) {
                                vm.enrolledNewCourse(courseId: courseId, token: appData.token, appData: appData)
                            }, secondaryButton: .destructive(Text("Huỷ")))
                        }
                    } else {
                        Button {
                            print("Khoa tra phi")
                        } label: {
                            ButtonGradientUI(titleButton: "Mua ngay")
                        }
                    }
                }
                .padding(.horizontal, 20)
                .background(.white)
            }
            // End Check is enrolled

            if vm.isLoading || vm.isLoadingEnroll {
                LoadingIndicatorView(isLoading: .constant(true))
            }
        }
        .sheet(isPresented: $vm.isShowSuccess) {
            if vm.newCourseEnrolled != nil {
                SuccessEnrolledCourse(courseReponse: vm.newCourseEnrolled!)
                    .presentationDetents([.medium])
            }
        }
        .onAppear {
            vm.fetchCourseDetailById(courseId: courseId)
        }
        .navigationBarTitleDisplayMode(.inline)
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
