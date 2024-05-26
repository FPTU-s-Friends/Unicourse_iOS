//
//  DetailInformationCourse.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/5/24.
//

import SwiftUI

struct DetailInformationCourse: View {
    var isLoadingSkeleton: Bool
    var subTitleDescription: [String]
    var subTitle: String
    var courseName: String

    var body: some View {
        if isLoadingSkeleton == true {
            SkeletonDetailInformationCourse()
        } else {
            VStack {
                VStack(spacing: 18) {

                    VStack(alignment: .leading) {
                        Text(subTitle)
                            .font(.system(size: 15, weight: .medium))

                        ForEach(subTitleDescription, id: \.hashValue) { item in
                            Text(item)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Color.neutralTextColor)
                        }
                    }
                }
                .frame(maxWidth: 306)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 17)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 0.1)
            )
            .cornerRadius(16)
        }
    }
}
