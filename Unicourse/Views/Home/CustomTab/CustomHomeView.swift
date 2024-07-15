//  CustomHomeView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import SwiftUI

struct CustomHomeView: View {
    @Binding var activeTab: Tab
    @State private var tabShapePosition: CGPoint = .zero
    @Namespace private var animation

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                HomeView()
                    .tag(Tab.home)

                NavigationView {
                    CourseView()
                }
                .tag(Tab.course)

                NavigationView {
                    QuizView()
                }
                .tag(Tab.quiz)

                NavigationView {
                    BlogView()
                }
                .tag(Tab.blog)

                AccountView()
                    .tag(Tab.account)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            CustomTabBar()
        }
    }

    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color.mainColor1, _ inactiveTint: Color = .gray) -> some View {
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
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -2)
                .blur(radius: 1)
        }
    }
}

#Preview {
    NavigationStack {
        CustomHomeView(activeTab: .constant(.home))
            .environmentObject(AppData())
    }
}
