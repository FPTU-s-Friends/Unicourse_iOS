//
//  ProgressBarComponent.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 1/6/24.
//

import SwiftUI

struct ProgressBarComponent: View {
    let value: Double
    let total: Double
    var isFinish: Bool {
        if value == total {
            return true
        }
        return false
    }

    private let barHeight: CGFloat = 12 // Độ dày của ProgressView

    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color.gray.opacity(0.2))
                        .frame(width: geometry.size.width, height: barHeight)
                        .cornerRadius(barHeight / 2)

                    Rectangle()
                        .foregroundColor(isFinish ? .green : .activeColor) // Replace .activeColor with a specific color
                        .frame(width: CGFloat(value / total) * geometry.size.width, height: barHeight)
                        .cornerRadius(barHeight / 2)
                        .animation(.easeInOut, value: value)

                    HStack {
                        Text(isFinish ? "✅" : "\(Int(value)) / \(Int(total))")
                            .font(.system(size: 12, weight: .semibold))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            .animation(.easeInOut, value: value)
                        Spacer()
                    }
                    .padding(.leading, max(CGFloat(value / total) * geometry.size.width - 44, 0))
                }
            }
            .frame(height: barHeight)
        }
    }
}

#Preview {
    ProgressBarComponent(value: 4, total: 4)
}
