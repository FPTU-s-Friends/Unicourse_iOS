//
//  SkeletonCourseRecentView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 29/5/24.
//

import SwiftUI

struct SkeletonCourseRecentView: View {
    var body: some View {
        // Skeleton View
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 55, height: 55)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 120, height: 20)
        }
        .frame(width: 200, height: 70)
        .padding(3)
        .background(Color.gray.opacity(0.1).cornerRadius(10))
        .shimmerWithWave()
    }
}

#Preview {
    SkeletonCourseRecentView()
}
