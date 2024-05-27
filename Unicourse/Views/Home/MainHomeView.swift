//  HomeView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct MainHomeView: View {
    @EnvironmentObject var appData: AppData

    // Define an array of tab items with label and system image name
    let tabBarItems = [
        ("Trang chủ", "house"),
        ("Khoá học", "book"),
        ("Cộng đồng", "person.3"),
        ("Tài khoản", "person.circle.fill")
    ]

    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $appData.mainTabSelection) {
                    ForEach(0 ..< tabBarItems.count, id: \.self) { index in
                        getView(for: index)
                            .tag(index)
                            .tabItem {
                                Label(tabBarItems[index].0, systemImage: tabBarItems[index].1)
                            }
                    }
                }
                .tint(.activeColor)
            }
        }
    }

    // Return appropriate view based on index
    @ViewBuilder
    private func getView(for index: Int) -> some View {
        switch index {
        case 0: HomeView()
        case 1: CourseView()
        case 2: CommunityView()
        case 3: AccountView()
        default: EmptyView()
        }
    }
}

#Preview {
    MainHomeView()
        .environmentObject(AppData())
}
