//
//  SkeletonHistoryTransactionItem.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 18/6/24.
//

import SwiftUI

struct HistoryTransactionItemSkeleton: View {
    @State private var isShowDetailHistory: Bool = false

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    // User Profile Image Skeleton
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 30, height: 30)
                        .shimmerWithWave()

                    // User Full Name Skeleton
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 100, height: 10)
                        .shimmerWithWave()

                    Spacer()

                    // Toggle Detail Button Skeleton
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 80, height: 30)
                        .shimmerWithWave()
                }
                .padding(.bottom, 10)

                // Transaction Item Skeleton
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: UIScreen.main.bounds.width * 0.3, height: 75)
                        .shimmerWithWave()

                    VStack(alignment: .leading, spacing: 6) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 10)
                            .shimmerWithWave()

                        HStack {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 50, height: 10)
                                .shimmerWithWave()

                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 50, height: 10)
                                .shimmerWithWave()
                        }
                    }
                }
                .padding(.bottom, 10)

                if isShowDetailHistory {
                    // Detailed Information Skeleton
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 150, height: 10)
                                .shimmerWithWave()

                            Spacer()

                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 50, height: 10)
                                .shimmerWithWave()
                        }

                        HStack {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 150, height: 10)
                                .shimmerWithWave()

                            Spacer()

                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 50, height: 10)
                                .shimmerWithWave()
                        }

                        HStack {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 150, height: 10)
                                .shimmerWithWave()

                            Spacer()

                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 80, height: 20)
                                .shimmerWithWave()
                        }
                    }
                    .padding(.bottom, 10)
                }

                // Footer Skeleton
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 10)
                            .shimmerWithWave()

                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 50, height: 10)
                            .shimmerWithWave()
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 6) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 50, height: 10)
                            .shimmerWithWave()

                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 20)
                            .shimmerWithWave()
                    }
                }
            }
            .padding(30)
            .background(Color.white.cornerRadius(10))
        }
        .padding(.horizontal, 15)
    }
}

struct HistoryTransactionItemSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTransactionItemSkeleton()
    }
}
