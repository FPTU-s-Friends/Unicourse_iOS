//
//  SkeletonBlogView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 4/6/24.
//

import SwiftUI

struct SkeletonBlogView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        VStack(alignment: .leading) {
            // Thumbnail Image Skeleton
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 210)
                .cornerRadius(10)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                .shimmerWithWave()

            // Title Skeleton
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 20)
                .cornerRadius(5)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                .shimmerWithWave()

            // User Info Skeleton
            HStack(spacing: 5) {
                // Profile Image Skeleton
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 20, height: 20)

                // User Name Skeleton
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 12)
                    .cornerRadius(5)
                    .padding(.horizontal, 5)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 5)
            .shimmerWithWave()

            // Tags Skeleton
            HStack(spacing: 5) {
                // Tag Skeletons
                ForEach(0 ..< 3) { _ in
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 16)
                        .cornerRadius(5)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 6)
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .shimmerWithWave()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal, 10)

        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 10)], spacing: 10) {
            ForEach(0 ..< 4) { _ in // Showing 6 skeleton items for demonstration
                VStack(alignment: .leading) {
                    // Thumbnail Image Skeleton
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 170, height: 100)
                        .cornerRadius(10)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)

                    // Title Skeleton
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 170, height: 15)
                        .cornerRadius(5)
                        .padding(.horizontal, 5)
                        .padding(.bottom, 5)

                    // User Info Skeleton
                    HStack(spacing: 5) {
                        // Profile Image Skeleton
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 20, height: 20)
                            .padding(.leading, 5)

                        // User Name Skeleton
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 140, height: 12)
                            .cornerRadius(5)
                            .padding(.horizontal, 5)
                    }
                }
                .shimmerWithWave()
                .background(Color.white)
                .cornerRadius(10)
            }
        }

        .padding(.horizontal, 10)
    }
}

#Preview {
    SkeletonBlogView()
}
