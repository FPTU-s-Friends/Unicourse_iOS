//
//  RecentItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 29/5/24.
//

import SwiftUI

struct RecentItemView: View {
    var enrollCourse: EnrollCourseUserInfo

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: enrollCourse.courseId.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.horizontal, 5)
                        .frame(width: 120, height: 100)

                } placeholder: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 100)
                        .padding(.horizontal, 5)
                        .shimmerWithWave()
                }
                .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text(enrollCourse.courseId.title)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.black)

                    HStack {
                        AsyncImage(url: URL(string: enrollCourse.courseId.lecture.profile_image)) { image in
                            image.resizable()
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .cornerRadius(20)
                        } placeholder: {
                            ZStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 20, height: 20)
                            }
                        }

                        Text(enrollCourse.courseId.lecture.fullName)
                            .font(.system(size: 10, weight: .light))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .foregroundStyle(.gray)
                    }

                    RatingStars(rating: 3.5, maxRating: 5)

                    HStack {
                        Text("\(enrollCourse.courseId.amount) VND")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.activeColor)
                        // ---
                        Text("\(enrollCourse.courseId.amount + 10000) VND")
                            .font(.system(size: 10, weight: .bold))
                            .strikethrough()
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 10)
            }
        }

        .background(Color.white.cornerRadius(10))
    }
}

#Preview {
    RecentItemView(enrollCourse: EnrollCourseUserInfo.sampleData)
}
