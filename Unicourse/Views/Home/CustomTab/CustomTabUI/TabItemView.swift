//
//  TabItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import SwiftUI

struct TabItemView: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position: CGPoint

    // each tab item position on the screen
    @State private var tabPosition: CGPoint = .zero
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: tab.systemImage)
                    .font(.title2)
                    .foregroundStyle(activeTab == tab ? .white : inactiveTint)
                    .frame(width: activeTab == tab ? 56 : 30, height: activeTab == tab ? 56 : 30)
                    .background {
                        if activeTab == tab {
                            Circle()
                                .fill(tint.gradient)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .padding(.bottom, 10)
            }

            Text(tab.rawValue)
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(activeTab == tab ? tint : .gray)
                .offset(y: 30)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX

            // updating active tab position
            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            withAnimation(.smooth()) {
                activeTab = tab
            }
        }
    }
}
