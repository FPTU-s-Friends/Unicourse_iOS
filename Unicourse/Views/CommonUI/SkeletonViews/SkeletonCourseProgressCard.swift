//
//  SkeletonCourseCard.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

struct SkeletonCourseProgressCard: View {
    var body: some View {
        VStack(spacing: 13) {
            HStack(alignment: .top, spacing: 10) {
                Circle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 32, height: 32)
                    .padding(.bottom, 20)
                    .padding(.leading, 10)
                Spacer()
            }

            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 180, height: 10)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 40, height: 20)
            }

            Divider()
                .background(Color.gray.opacity(0.2))
        }
        .padding(14)
        .frame(width: 258, height: 160)
        .background(Color.gray.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 0.1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shimmerWithWave()
    }
}

#Preview {
    SkeletonCourseProgressCard()
}
