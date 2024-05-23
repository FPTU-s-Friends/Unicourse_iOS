//
//  SkeletonTrackingCourseView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

struct SkeletonTrackingCourseView: View {
    var body: some View {
        VStack(spacing: 11) {
            HStack(alignment: .top, spacing: 12) {
                // Thumbnail Placeholder
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 46, height: 46)

                VStack(alignment: .leading, spacing: 5) {
                    // Week Placeholder
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 50, height: 12)

                    // Description Placeholder
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 212, height: 40)
                }
                Spacer()
            }

            HStack {
                // User Avatar Placeholder
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 24, height: 24)

                // Username Placeholder
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 100, height: 12)

                Spacer()

                // Continue Button Placeholder
                RoundedRectangle(cornerRadius: 7, style: .continuous)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 100, height: 30)
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: 133)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shimmerWithWave()
    }
}

#Preview {
    SkeletonTrackingCourseView()
}
