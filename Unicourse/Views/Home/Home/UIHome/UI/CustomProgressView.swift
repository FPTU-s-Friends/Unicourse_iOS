//
//  CustomProgressView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct CustomProgressView: View {
    let value: Double
    let total: Double
    let barHeight: CGFloat = 8 // Độ dày của ProgressView
    let barSpacing: CGFloat = 2 // Khoảng cách giữa các lớp

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.2))
                    .frame(width: geometry.size.width, height: barHeight)
                    .cornerRadius(barHeight / 2)

                Rectangle()
                    .foregroundColor(.activeColor)
                    .frame(width: CGFloat(value / total) * geometry.size.width, height: barHeight)
                    .cornerRadius(barHeight / 2)
            }
        }
        .frame(height: barHeight)
    }
}

#Preview {
    CustomProgressView(value: 14, total: 100)
}
