//
//  BasicInfo.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 9/5/24.
//

import SwiftUI

struct BasicInfo: View {
    var courseName: String
    var courseAvgRating: Double
    var courseTotalRatingCount: Int
    var memberCount: Int
    var newPrice: Double?
    var oldPrice: Double?
    var isLoading: Bool

    var body: some View {
        VStack {
            if isLoading {
                SkeletonBasicInfo()
            } else {
                VStack {
                    Text(courseName)
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer(minLength: 36)
                    HStack {
                        RatingStars(rating: courseAvgRating)

                        Text("\(courseTotalRatingCount) Đánh giá")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "#8D8A8A"))

                        Divider()

                        Text("\(memberCount) Học viên")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "#8D8A8A"))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer(minLength: 16)

                    HStack {
                        Text("299.000 vnđ")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(Color(hex: "#8D8A8A"))

                        Text("499.000 vnđ")
                            .font(.system(size: 12))
                            .strikethrough()
                            .foregroundStyle(Color(hex: "#8D8A8A"))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

#Preview {
    BasicInfo(courseName: "Khoá học OSG202 - Hệ điều hành", courseAvgRating: 3.3, courseTotalRatingCount: 100, memberCount: 92, newPrice: 299.000, oldPrice: 1.000, isLoading: false)
}
