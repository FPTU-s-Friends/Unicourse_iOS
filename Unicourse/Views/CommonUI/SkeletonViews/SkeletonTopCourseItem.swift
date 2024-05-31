//
//  SkeletonTopCourseItem.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 31/5/24.
//

import SwiftUI

struct SkeletonTopCourseItem: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .cornerRadius(20)

                VStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                        .cornerRadius(5)
                        .padding(.horizontal, 5)

                    HStack {
                        ForEach(0 ..< 5) { _ in
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.top, -5)

                    HStack(alignment: .top, spacing: 0) {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 28, height: 28)

                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 20)
                            .cornerRadius(10)
                            .padding(.horizontal, 10)

                        Spacer()

                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 50, height: 20)
                            .cornerRadius(10)
                            .padding(5)
                            .padding(.horizontal, 10)
                    }

                    VStack {
                        HStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60, height: 20)
                                .cornerRadius(5)

                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 80, height: 20)
                                .cornerRadius(5)
                                .strikethrough()
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(10)
            }

            VStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 20)
                    .cornerRadius(10)
                    .padding(5)
                    .padding(.horizontal, 10)
                    .offset(x: 130, y: -130)
            }
        }
        .shimmerWithWave()
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    SkeletonTopCourseItem()
}
