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
                /// Cardx
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
                    VStack(spacing: 11) {
                        HStack(alignment: .top, spacing: 12) {
                            VStack {
                                Image("3dicons")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 46, height: 46)
                            }
                            .padding(10)
                            .background(Color(hex: "#FBCCCE"))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                            VStack(alignment: .leading, spacing: 5) {
                                Text("Tuần 2")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.mainColor2)

                                HStack(alignment: .center, spacing: 12) {
                                    // Icon Tracking Course
                                    ZStack {
                                        Image(.trackingCourseLine)
                                        Image(.trackingCourseCircle)
                                    }
                                    // End Icon Tracking Course
                                    Text("Xây dựng bằng các vật liệu và kỹ thuật khác nhau: gỗ, đá, v.v.")
                                        .font(.system(size: 14, weight: .medium))
                                        .frame(width: 212, height: 40)
                                }
                            }
                            Spacer()
                        }

                        HStack {
                            Group {
                                Image(.user)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)

                                Text("Nguyễn Trung Kiên")
                                    .font(.system(size: 12))
                                    .foregroundColor(.mainColor2)
                            }
                            Spacer()
                            Group {
                                VStack {
                                    Image(systemName: "square.stack.3d.up")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 18, height: 18)
                                }
                                .padding(6)
                                .background(Color(hex: "#DDE0FF"))
                                .clipShape(RoundedRectangle(cornerRadius: 7.0))

                                // Button
                                NavigationLink(destination:
                                    CourseDetailView()
                                        .navigationBarBackButtonHidden(true),
                                    label: {
                                        Text("Tiếp tục")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundStyle(.white)
                                            .frame(width: 100, height: 30)
                                            .background(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom))
                                            .clipShape(RoundedRectangle(cornerRadius: 7.0))
//                                        Text("Next")/
                                    })
                            }
                        }
                    }
                    .padding(10)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, maxHeight: 133)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16.0))
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
                /// End  card

                // Current learning  course
                ScrollView {
                    VStack(spacing: 16) {
                        // Title
                        PathTitle(title: "Đang học", isHaveButton: true,
                                  actionButton: { showingCredits.toggle() })
                            .padding(.trailing, 28)
                            .sheet(isPresented: $showingCredits) {
                                AllCourseView()
                                    .presentationDetents([.medium])
                            }

                        // List card
                        if vm.listEnrolledCourses.count > 0 {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(vm.listEnrolledCourses, id: \._id) { courseItem in
                                        CourseCard(courseItem: courseItem)
                                    }
                                }
                            }
                        } else {
                            VStack {
                                Image(systemName: "xmark.icloud.fill")
                                    .font(.system(size: 32, weight: .regular))
                                    .foregroundStyle(.gray)

                                Text("No data found")
                                    .font(.system(size: 12, weight: .light))
                            }
                        }

                        // End List card
                    }
                    .padding(.leading, 8)
                    .padding(.bottom, 15)

                    // End Current learning  course
                    VStack(spacing: 10) {
                        PathTitle(title: "Tất cả khoá học", isHaveButton: false, actionButton: {})
                            .padding(.trailing, 28)

                        HStack(spacing: 4) {
                            Text("Tất cả")
                                .font(.system(size: 12))
                                .padding(5)
                                .padding(.horizontal, 10)
                                .foregroundStyle(.white)
                                .background(Color(hex: "#16AEF4"))
                                .cornerRadius(16)
                            Text("Đang học")
                                .font(.system(size: 12))
                                .padding(5)
                                .padding(.horizontal, 10)
                                .cornerRadius(16)
                            Text("Đã hoàn thành")
                                .font(.system(size: 12))
                                .padding(5)
                                .padding(.horizontal, 10)
                                .cornerRadius(16)
                            Spacer()
                        }
                        LazyVStack {
                            ForEach(vm.listEnrolledCourses, id: \._id) {
                                courseItem in
                                NavigationLink(destination: CourseDetailView()) {
                                    CourseListView(courseItem: courseItem)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }.padding(.bottom, 100)

                    }.padding(.leading, 12)
                }
                .refreshable {
                    vm.fetchListEnrolledCourses(userId: appData.user?.userId ?? mockUserId, token: appData.token, isRefresh: true)
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

@ViewBuilder
func AllCourseView() -> some View {
    Text("All courses appears here")
}

#Preview {
    CourseView()
        .environmentObject(AppData())
}
