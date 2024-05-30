//
//  TopCourseViewItem.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 30/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct TopCourseViewItem: View {
    @Environment(\.colorScheme) var colorScheme
    var course: SearchCourseModel

    var body: some View {
        ZStack {
            VStack {
                WebImage(url: URL(string: course.thumbnail)!) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .cornerRadius(20)

                } placeholder: {
                    ProgressView()
                }

                VStack(alignment: .leading) {
                    VStack {
                        Text(course.title)
                            .font(.system(size: 14, weight: .semibold))
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .padding(.horizontal, 5)
                    }

                    RatingStars(rating: 4, maxRating: 5)
                        .padding(.horizontal, 5)
                        .padding(.top, -5)

                    HStack(alignment: .top, spacing: 0) {
                        Image(.user)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)

                        VStack(alignment: .leading) {
                            Text(course.lecture.fullName)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                .padding(5)
                                .background(.ultraThickMaterial)
                                .cornerRadius(10)
                        }

                        Spacer()

                        Text("\(course.type == .free ? "Free" : "Paid")")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(course.type == CourseEnrollType.free ? Color.green.gradient : Color.blue.gradient)
                            .padding(5)
                            .padding(.horizontal, 10)
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                    }

                    VStack {
                        if course.type == .free {
                            Text("\(course.amount + 40000) VND")
                                .font(.system(size: 14, weight: .bold))
                                .strikethrough()
                                .lineSpacing(20)
                                .foregroundColor(.mainColor1)

                        } else {
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("\(course.amount) đ")
                                    .font(.system(size: 14, weight: .bold))
                                    .lineSpacing(20)
                                    .foregroundColor(.mainColor1)
                                Text("\(course.amount + 20000) VND")
                                    .font(.system(size: 12))
                                    .lineSpacing(20)
                                    .strikethrough()
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 15)
                            .padding(.bottom, 10)
                        }
                    }
                    .padding(.horizontal, 5)
                }
                .padding(.horizontal, 10)
            }

            VStack {
                Text("New")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .padding(5)
                    .padding(.horizontal, 10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .offset(x: 95, y: -100)
            }
        }
        .frame(width: 270, height: 260)
        .background(colorScheme == .dark ? .black : .white)
        .cornerRadius(20)
    }
}

#Preview {
    TopCourseViewItem(course: SearchCourseModel.sampleData)
}
