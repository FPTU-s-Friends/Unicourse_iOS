//
//  SkeletonQuizItemListUI.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 9/6/24.
//

import SwiftUI

struct SkeletonQuizItemListUI: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                // Placeholder for Image
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .padding(.horizontal, 5)
                    .frame(width: 130, height: 100)
                    .cornerRadius(10)
                    .shimmerWithWave()

                VStack(alignment: .leading) {
                    // Placeholder for Title
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 140, height: 14)
                        .padding(.bottom, 5)
                        .shimmerWithWave()

                    // Placeholder for Creator Info
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 14)
                        .padding(.bottom, 5)
                        .shimmerWithWave()

                    // Placeholder for Number of Questions
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 15)
                        .shimmerWithWave()

                    // Placeholder for Viewer Info
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 50, height: 15)
                            .shimmerWithWave()

                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 15)
                            .shimmerWithWave()
                    }
                    .padding(.top, 5)
                }
            }
        }
        .frame(height: 100)
    }
}

#Preview {
    SkeletonQuizItemListUI()
}
