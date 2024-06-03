//
//  NavigationQuizButtonComponents.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 1/6/24.
//

import SwiftUI

struct NavigationQuizButtonComponents: View {
    var totalQuestion: Int
    @Binding var selectedTab: Int

    var canClickPrev: Bool {
        if selectedTab > 0 {
            return true
        }
        return false
    }

    var canClickNext: Bool {
        if selectedTab < totalQuestion - 1 {
            return true
        }
        return false
    }

    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                if selectedTab > 0 {
                    selectedTab -= 1
                }
            }, label: {
                HStack {
                    Image(systemName: "arrowtriangle.left.fill")
                    Text("Câu trước")
                }
            })
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .foregroundStyle(canClickPrev ? .white : .gray.opacity(0.5))
            .background(canClickPrev ? Color.activeColor : .white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(canClickPrev ? Color.activeColor : .white, lineWidth: 2)
            )
            .cornerRadius(8)
            .animation(.spring(), value: canClickPrev)

            Button(action: {
                if selectedTab < totalQuestion - 1 {
                    selectedTab += 1
                }
            }, label: {
                HStack {
                    Text("Câu sau")
                    Image(systemName: "arrowtriangle.right.fill")
                }
            })
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .foregroundStyle(canClickNext ? .white : .gray.opacity(0.5))
            .background(canClickNext ? Color.activeColor : .white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(canClickNext ? Color.activeColor : .white, lineWidth: 2)
            )
            .cornerRadius(8)
            .animation(.spring(), value: canClickNext)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    NavigationQuizButtonComponents(totalQuestion: 20, selectedTab: .constant(2))
}
