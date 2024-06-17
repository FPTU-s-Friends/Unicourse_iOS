//
//  EditSheetView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 9/6/24.
//

import SwiftUI

struct EditSheetView: View {
    @EnvironmentObject var appData: AppData

    var body: some View {
        ScrollView {
            VStack {
                // Profile Image
                AsyncImage(url: URL(string: appData.userInfo?.profileImage ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.2)
                        .clipShape(Circle())
                } placeholder: {
                    Image(.defaultProfile)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.2)
                        .clipShape(Circle())
                        .shimmerWithWave()
                }

                // User Info
                VStack(alignment: .leading) {
                    Text(appData.userInfo?.fullName ?? "")
                        .font(.system(size: 22, weight: .bold))
                        .bold()
                }
                .padding(.bottom, 20)

                // Introduction
                VStack(alignment: .leading) {
                    HStack {
                        Text("Giới thiệu")
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                    }

                    HStack(alignment: .center) {
                        Image(systemName: "envelope.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundStyle(Color.mainColor1)
                        Text(appData.userInfo?.email ?? "")
                            .font(.system(size: 12))
                    }
                    .font(.system(size: 14))
                    .foregroundStyle(Color.neutralTextColor)

                    HStack {
                        Image(systemName: "person.2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundStyle(Color.green)
                        Text("Là thành viên của Unicourse từ \(timeSinceCreated(date: appData.userInfo?.createdAt))")
                            .font(.system(size: 12, weight: .light))
                    }
                }
                .padding(.bottom, 10)

                // Description
                VStack(alignment: .leading) {
                    HStack {
                        Text("Mô tả")
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                    }

                    Text("Người dùng hiện chưa cập nhật mô tả.")
                        .font(.system(size: 12, weight: .light))
                        .padding(.vertical, 10)
                        .multilineTextAlignment(.center)
                }

                // Enrolled Courses
                VStack {
                    HStack {
                        Text("Các khoá học đã tham gia")
                            .font(.system(size: 16, weight: .semibold))
                        Spacer()
                    }
                    if let enrollCourses = appData.userInfo?.enrollCourses, !enrollCourses.isEmpty {
                        LazyVStack {
                            ForEach(enrollCourses, id: \._id) { item in
                                MyCourseItemUIView(course: item)
                            }
                        }
                    } else {
                        NotfoundView(systemName: "shippingbox.fill", message: "Người dùng chưa đăng ký khoá học nào")
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 50)
        .background {
            Color.mainBackgroundColor
                .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    EditSheetView()
        .environmentObject(AppData())
}
