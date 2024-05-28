//  CustomHomeView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import SwiftUI

struct CustomHomeView: View {
    @State private var activeTab: Tab = .home
    @State private var tabShapePosition: CGPoint = .zero
    @Namespace private var animation

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                HomeView()
                    .tag(Tab.home)

                CourseView()
                    .tag(Tab.course)

                CommunityView()
                    .tag(Tab.community)

                AccountView()
                    .tag(Tab.account)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            CustomTabBar()
        }
    }

    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color.activeColor, _ inactiveTint: Color = .gray) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabItemView(tint: tint,
                            inactiveTint: inactiveTint,
                            tab: tab,
                            animation: animation,
                            activeTab: $activeTab,
                            position: $tabShapePosition)
            }
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
        .background {
            TabShape(midPoint: tabShapePosition.x)
                .fill(Color.mainBackgroundColor)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
        }
    }
}

#Preview {
    NavigationStack {
        CustomHomeView()
            .environmentObject(AppData())
    }
}
