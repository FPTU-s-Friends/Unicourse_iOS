//  HomeView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct MainHomeView: View {
    @EnvironmentObject var appData: AppData

    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $appData.mainTabSelection) {
                    HomeView()
                        .tabItem {
                            Label("Trang chủ", systemImage: "house")
                        }
                        .tag(1)

                    CourseView()
                        .tabItem {
                            Label("Khoá học", systemImage: "book")
                        }
                        .tag(2)

                    CommunityView()
                        .tabItem {
                            Label("Cộng đồng", systemImage: "person.3")
                        }
                        .tag(3)

                    AccountView()
                        .tabItem {
                            Label("Tài khoản", systemImage: "person.circle.fill")
                        }
                        .tag(4)
                }
                .tint(.activeColor)
            }
        }
    }
}

#Preview {
    MainHomeView()
        .environmentObject(AppData())
}
