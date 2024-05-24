//
//  SkeletonCourseCard.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

struct SkeletonCourseCard: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 270, height: 160)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 20, height: 20)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 100, height: 20)
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 50, height: 20)
                }
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 200, height: 20)
            }
            .padding(10)
            .frame(width: 260)
        }
        .padding(.leading, 10)
        .shimmerWithWave()
    }
}

#Preview {
    SkeletonCourseCard()
}
