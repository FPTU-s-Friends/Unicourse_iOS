//
//  SkeletonGridCourseView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

// Skeleton View
struct SkeletonGridCourseView: View {
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                VStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 100)
                        .shimmerWithWave()
                }
                .frame(width: 190)
                .padding(.top, 10)

                VStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 20, height: 20)

                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 10)
                    }
                }
                .padding(.horizontal, 15)
                .shimmerWithWave()

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 10)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)
                    .shimmerWithWave()

                Spacer()

                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 10)

                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 10)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
                .shimmerWithWave()
            }

            HStack(alignment: .top, spacing: 4) {
                ForEach(0 ..< 5) { _ in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                  
                }
            }
            .padding(2)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(5)
            .padding(.horizontal, 5)
            .offset(x: -40, y: 100)
            .shimmerWithWave()
        }
        .frame(width: UIScreen.main.bounds.width * 0.47, height: 260)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(12)
    }
}

#Preview {
    SkeletonGridCourseView()
}
