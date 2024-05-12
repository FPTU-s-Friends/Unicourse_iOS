//
//  CustomPageControlHomeView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct CustomPageControlHomeView: View {
    var numberOfPages: Int
    @Binding var currentPage: Int

    let dotHeight: CGFloat = 4
    let dotSpacing: CGFloat = 10

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let dotWidth = (totalWidth - CGFloat(numberOfPages - 1) * dotSpacing) / CGFloat(numberOfPages)

            HStack(spacing: dotSpacing) {
                ForEach(Array(0 ..< numberOfPages), id: \.self) { page in
                    Rectangle()
                        .fill(page == currentPage ? Color.activeColor : Color.gray)
                        .frame(width: dotWidth, height: dotHeight)
                        .cornerRadius(10)
                }
            }
            .frame(width: totalWidth, height: dotHeight)
            .position(x: geometry.size.width / 2)
        }
        .frame(height: 5)
        .padding(.horizontal, 20)
    }
}

#Preview {
    CustomPageControlHomeView(numberOfPages: 3, currentPage: .constant(0))
}
