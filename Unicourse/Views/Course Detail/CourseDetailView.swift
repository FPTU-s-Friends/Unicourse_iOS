//
//  CourseDetailView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 9/5/24.
//

import SwiftUI

struct CourseDetailView: View {
    @EnvironmentObject var appData: AppData
    @StateObject private var vm = CourseDetailViewModel()

    @State private var isFav: Bool = false
    @State private var tabSelection = 0
    @State private var isAddToCart = false
    @State private var isOpenGemini = false
    @State private var isNavigateToCartView = false
    @State private var confirmEnrollFreeCourse = false
    @State private var isShowingPaymentMethod = false

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

    var isInCart: Bool {
        appData.cart?.items.contains(where: { $0._id == courseId }) == true
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(Color.mainBackgroundColor)
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 16) {
                    // Go Back Button -      Favorite Button - Share Button
                    VStack {
                        if let url = URL(string: vm.courseDetail?.thumbnail ?? "default") {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width * 0.95)
                                    .cornerRadius(20)

                            } placeholder: {
                                RoundedRectangle(cornerRadius: 24.0)
                                    .frame(width: UIScreen.main.bounds.width * 0.95, height: 200)
                                    .foregroundStyle(Color.gray.opacity(0.5))
                                    .shimmerWithWave()
                            }
                        } else {
                            RoundedRectangle(cornerRadius: 24)
                                .frame(height: 200)
                                .foregroundStyle(Color.gray.opacity(0.5))
                        }
                    }
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
            .padding(.horizontal, 10)

            // Check is enrolled

            if isEnrolled {
                enrolledView()
            } else {
                purchaseOptionsView()
            }
            // End Check is enrolled

            ButtonDragUIView()
                .onTapGesture {
                    withAnimation(.spring) {
                        isOpenGemini = true
                    }
                }

            if vm.isLoading || vm.isLoadingEnroll || vm.isLoadingAddToCart {
                LoadingIndicatorView(isLoading: .constant(true))
            }
        }
        .navigationDestination(isPresented: $isNavigateToCartView, destination: {
            CartView()
        })
        .sheet(isPresented: $isShowingPaymentMethod) {
            NavigationView {
                CheckoutView()
                    .presentationDetents([.medium, .large])
            }
        }
        .sheet(isPresented: $isOpenGemini) {
            GeminiPromptView(isOpenGemini: $isOpenGemini)
                .presentationDetents([.large])
                .presentationCornerRadius(30)
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $vm.isAddTocartSuccess, content: {
            VStack {
                Group {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.green)

                    Text("Thành công !")
                        .font(.title)
                        .bold()
                }
                Text("Thêm khoá học vào giỏ hàng thành công!")

                Button(action: {
                    vm.isAddTocartSuccess = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isNavigateToCartView = true
                    }
                }) {
                    ButtonGradientUI(titleButton: "Giỏ hàng của tôi")
                        .padding(20)
                }
            }
            .presentationDetents([.medium])
        })
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
            toolBarContentLeft()
            toolbarContentRight()
        }
    }

    // Logic show Bottom Button
    @ViewBuilder
    private func enrolledView() -> some View {
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
    }

    @ViewBuilder
    private func purchaseOptionsView() -> some View {
        HStack(alignment: .center) {
            if !isInCart {
                addToCartButton()
            }

            if isFree {
                enrollFreeCourseButton()
            } else {
                buyCourseButton()
            }
        }
        .padding(.horizontal, 20)
        .background(.white)
    }

    @ViewBuilder
    private func addToCartButton() -> some View {
        AddToCartButton {
            if isFree {
                isAddToCart.toggle()
            } else {
                Task {
                    vm.isLoadingAddToCart = true
                    try await vm.addToCart(token: appData.token)
                    if vm.isAddTocartSuccess {
                        try await appData.getUserCart(token: appData.token)
                    }
                    vm.isLoadingAddToCart = false
                }
            }
        }
        .alert(isPresented: $isAddToCart) {
            Alert(title: Text("Khoá miễn phí"), dismissButton: .default(Text("Đóng")))
        }
    }

    @ViewBuilder
    private func enrollFreeCourseButton() -> some View {
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
    }

    @ViewBuilder
    private func buyCourseButton() -> some View {
        Button {
            if isInCart {
                isNavigateToCartView = true
            } else {
                isShowingPaymentMethod = true
            }
        } label: {
            ButtonGradientUI(titleButton: "Mua ngay")
        }
    }

    // End of Logic show Bottom Button

    // ToolBar Content
    private func toolBarContentLeft() -> some ToolbarContent {
        return ToolbarItem(placement: .topBarLeading) {
            ButtonBackUIView()
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }

    private func toolbarContentRight() -> some ToolbarContent {
        return ToolbarItem(placement: .topBarTrailing) {
            HStack(spacing: 0) {
                Button(action: {
                    isFav.toggle()
                }, label: {
                    CircleButtonUI(isActive: isFav, systemName: "heart.circle", symbolRenderingMode: .multicolor)
                })

                NavigationLink(destination: CartView()) {
                    ZStack {
                        Image(systemName: "cart.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundStyle(
                                Color.white,
                                Color.mainColor1.gradient
                            )
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        if let cart = appData.cart, !cart.items.isEmpty {
                            Text("\(cart.items.count)")
                                .font(.system(size: 10))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(Color.activeColor.cornerRadius(10))
                                .padding(.leading, 20)
                                .padding(.bottom, 20)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }

                Button(action: {}, label: {
                    Image(systemName: "arrowshape.turn.up.right.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundStyle(
                            Color.white,
                            Color.mainColor1.gradient
                        )
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

                })
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
