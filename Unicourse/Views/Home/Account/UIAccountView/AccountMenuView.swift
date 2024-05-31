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
    var menuItems: [MenuItem]
    @State private var showAlert = false
    @State private var isLoggedOut = false

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

            LogoutButtonView(showAlert: $showAlert, isLoggedOut: $isLoggedOut, action: { appData.signOutUser() })
                .padding(.top, 10)
                .padding(.leading, 2)
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
    @Binding var isLoggedOut: Bool
    var action: () -> Void

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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Xác nhận"),
                message: Text("Bạn có chắc chắn muốn đăng xuất không?"),
                primaryButton: .destructive(Text("Có")) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        action()
                    }
                },
                secondaryButton: .cancel(Text("Không"))
            )
        }
        .fullScreenCover(isPresented: $isLoggedOut) {
            LoginView()
        }
    }
}

#Preview {
    AccountMenuView(menuItems: AccountViewModel().menuItems)
        .environmentObject(AppData())
}
