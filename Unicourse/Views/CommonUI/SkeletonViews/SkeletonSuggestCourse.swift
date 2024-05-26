//
//  SwiftUIView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 26/5/24.
//

import SwiftUI

struct SkeletonSuggestCourse: View {
    var body: some View {
        HStack(spacing: 4) {
            // Placeholder for AsyncImage
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 140, height: 80)
                .padding(.trailing, 10)

            // Placeholder for Text
            VStack(alignment: .leading, spacing: 10) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 140, height: 16)

                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 16)
            }
            .padding(.horizontal, 20)
        }
        .shimmerWithWave()
        .cornerRadius(5)
        .redacted(reason: .placeholder)
    }
}

#Preview {
    SkeletonSuggestCourse()
}
