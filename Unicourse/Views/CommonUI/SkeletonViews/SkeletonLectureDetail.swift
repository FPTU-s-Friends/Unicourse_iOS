//
//  SkeletonLectureDetail.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 31/5/24.
//

import SwiftUI

struct SkeletonLectureDetail: View {
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 70, height: 70)

            VStack(alignment: .leading, spacing: 10) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 22)

                HStack(alignment: .center, spacing: 5) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 20, height: 20)

                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 200, height: 14)
                }
            }
            Spacer()
        }
        .padding(.bottom, 20)

        HStack(spacing: 40) {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 14)

                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 30, height: 18)
            }
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 14)

                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 30, height: 18)
            }
            Spacer()
        }
        .padding(.bottom, 20)

        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 18)
                Spacer()
            }

            VStack(alignment: .leading, spacing: 10) {
                ForEach(0 ..< 5) { _ in
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                }
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 14)
                    .padding(.top, 10)
            }
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    SkeletonLectureDetail()
}
