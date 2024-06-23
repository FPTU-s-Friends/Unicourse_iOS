//
//  AccountMenuView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct AccountMenuView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var isLoggedOut = false
    @State private var isShowAlertSignOut1 = false
    @State private var isShowAlertSignOut2 = false
    var menuItems: [MenuItem]

    var body: some View {
        VStack(spacing: 5) {
            ForEach(menuItems) { menuItem in
                VStack {
                    if menuItem.id == 2 {
                        NavigationLink(destination: menuItem.destination
                            .navigationBarTitle(menuItem.title, displayMode: .large)
                            .navigationBarBackButtonHidden(true))
                        {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Image(systemName: menuItem.systemName)
                                        .foregroundStyle(menuItem.colorIcon)
                                    Text(menuItem.title)
                                        .foregroundStyle(.black)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image("arrow-right")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 25, height: 25)
                                }
                            }
                        }
                        .padding(.top, 15)

                        if let enrollCourses = appData.userInfo?.enrollCourses, enrollCourses.isEmpty, enrollCourses == nil {
                            VStack {}
                                .padding(.top, 5)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 10) {
                                    ForEach((appData.userInfo?.enrollCourses ?? []).sorted(by: { $0.enrollDate > $1.enrollDate }), id: \._id) { course in
                                        NavigationLink(destination: CourseDetailView(courseId: course.courseId._id)) {
                                            CourseItemView(course: course, colorScheme: colorScheme)
                                        }
                                    }
                                }
                                .frame(height: 70)
                            }
                        }
                        Divider()

                    } else {
                        NavigationLink(destination: menuItem.destination
                            .navigationBarTitle(menuItem.title, displayMode: .large)
                            .navigationBarBackButtonHidden(true))
                        {
                            MenuItemView(menuItem: menuItem)
                        }
                        .padding(.top, 15)

                        Divider()
                    }
                }
            }
            .alert(isPresented: $appData.isShowingAlert) {
                Alert(
                    title: Text("Error").foregroundStyle(Color.red),
                    message: Text(appData.error),
                    dismissButton: .cancel(Text("Ok")) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            appData.isShowingAlert = false
                        }
                    }
                )
            }

            LogoutButtonView(showAlert: $isShowAlertSignOut1)
                .padding(.top, 10)
                .padding(.leading, 2)
                .alert(isPresented: $isShowAlertSignOut1) {
                    Alert(
                        title: Text("Xác nhận"),
                        message: Text("Bạn có chắc chắn muốn đăng xuất không?"),
                        primaryButton: .destructive(Text("Có")) {
                            withAnimation(.spring) {
                                appData.isLoading = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    Task {
                                        do {
                                            try appData.signOutUser()
                                            isLoggedOut = true // Set isLoggedOut to true after sign out
                                            appData.mainTabSelection = 0
                                        } catch {
                                            appData.error = "Lỗi khi đăng xuất"
                                            appData.isShowingAlert = true
                                        }
                                        appData.isLoading = false
                                    }
                                }
                            }
                        },
                        secondaryButton: .cancel(Text("Không"))
                    )
                }
                .navigationDestination(isPresented: $isLoggedOut) {
                    LoginView()
                }
        }
        .padding(.horizontal, 30)
    }
}

struct CourseItemView: View {
    let course: EnrollCourseUserInfo
    let colorScheme: ColorScheme

    var body: some View {
        HStack {
            WebImage(url: URL(string: course.courseId.thumbnail)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 55)
                    .cornerRadius(10)
            }

            placeholder: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 70, height: 55)
                    .shimmerWithWave()
            }

            Text(course.courseId.title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
        }
        .frame(width: 200, height: 70)
        .padding(.horizontal, 5)
        .background(Color.gray.opacity(0.1).cornerRadius(10))
    }
}

struct MenuItemView: View {
    let menuItem: MenuItem

    var body: some View {
        HStack {
            Image(systemName: menuItem.systemName)
                .foregroundStyle(menuItem.colorIcon)
            Text(menuItem.title)
                .foregroundStyle(.black)
                .fontWeight(.semibold)
            Spacer()
            Image("arrow-right")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
        }
    }
}

struct LogoutButtonView: View {
    @Binding var showAlert: Bool

    var body: some View {
        Button {
            showAlert = true
        } label: {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                    .foregroundStyle(.red)
                Text("Đăng xuất")
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                Spacer()
            }
        }
    }
}

#Preview {
    AccountMenuView(menuItems: AccountViewModel().menuItems)
        .environmentObject(AppData())
}
