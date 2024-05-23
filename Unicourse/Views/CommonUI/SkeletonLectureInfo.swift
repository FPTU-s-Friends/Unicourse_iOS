//
//  SkeletonLectureInfo.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 23/5/24.
//

import SwiftUI

struct SkeletonLectureInfo: View {
    var body: some View {
        VStack {
            // Skeleton loading view
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 40)
                }
                VStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 14)
                    HStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 12)
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 12)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 30)
                    .cornerRadius(7.0)
            }

            VStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 100)
                    .padding(12)
                    .frame(width: 295)
                    .background(Color(hex: "#F7F8FC"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 0.2)
                    )
                    .cornerRadius(16.0)
            }
        }
    }
}

#Preview {
    SkeletonLectureInfo()
}
