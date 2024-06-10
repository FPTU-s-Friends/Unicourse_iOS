//
//  SkeletonCourseListView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

struct SkeletonCourseListView: View {
    var body: some View {
        HStack(spacing: 13.0) {
            // Skeleton for image
            RoundedRectangle(cornerRadius: 8.0)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 64, height: 64)
                .foregroundColor(Color.gray.opacity(0.3))
                .shimmerWithWave()
            
            VStack(alignment: .leading, spacing: 20) {
                // Skeleton for title
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 180, height: 16)
                    .foregroundColor(Color.gray.opacity(0.3))
                    .shimmerWithWave()
                
                // Skeleton for date and progress
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 12)
                        .foregroundColor(Color.gray.opacity(0.3))
                        .shimmerWithWave()
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 12)
                        .foregroundColor(Color.gray.opacity(0.3))
                        .shimmerWithWave()
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 30, height: 12)
                        .foregroundColor(Color.gray.opacity(0.3))
                        .shimmerWithWave()
                }
            }
            
            Spacer()
            
            // Skeleton for forward arrow
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 24, height: 24)
                .foregroundColor(Color.gray.opacity(0.3))
                .shimmerWithWave()
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
    SkeletonCourseListView()
}
