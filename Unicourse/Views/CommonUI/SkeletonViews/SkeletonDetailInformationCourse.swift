//
//  SkeletonDetailInformationCourse.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 24/5/24.
//

import SwiftUI

struct SkeletonDetailInformationCourse: View {
    @State private var isLoading = true

    var body: some View {
        VStack(spacing: 18) {
            HStack(alignment: .top) {
                ImagePlaceholder()
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 6.0))

                TextPlaceholder()
                    .frame(height: 20)
                    .frame(maxWidth: 200, alignment: .leading)
                Spacer()
            }

            VStack {
                TextPlaceholder()
                    .frame(height: 20)
                    .frame(maxWidth: .infinity)

                Spacer(minLength: 12)

                TextPlaceholder()
                    .frame(height: 20)
                    .frame(maxWidth: .infinity)

                Spacer(minLength: 12)

                TextPlaceholder()
                    .frame(height: 20)
                    .frame(maxWidth: .infinity)

                ButtonPlaceholder()
                    .frame(height: 20)
                    .frame(maxWidth: 80)
            }
            .frame(maxWidth: 306)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 17)
        .background(Color.gray.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 0.1)
        )
        .cornerRadius(16)
    }
}

struct ImagePlaceholder: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.gray.opacity(0.3))
    }
}

struct TextPlaceholder: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.gray.opacity(0.3))
    }
}

struct ButtonPlaceholder: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.gray.opacity(0.3))
    }
}

#Preview {
    SkeletonDetailInformationCourse()
}
