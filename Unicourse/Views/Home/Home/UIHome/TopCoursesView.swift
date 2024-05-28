//
//  TopCoursesView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct TopCoursesView: View {
    @Binding var isLoadingSearchCourse: Bool
    @Environment(\.colorScheme) var colorScheme
    var searchCourses: [SearchCourseModel]
    var headerText: String

    var body: some View {
        HeaderCategoryView(textCategory: headerText,
                           textButton: TextButton.viewMore,
                           action: {})

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if self.isLoadingSearchCourse || self.searchCourses.isEmpty {
                    ForEach(0 ..< 3) { _ in
                        SkeletonCourseProgressCard()
                    }
                } else {
                    ForEach(searchCourses, id: \._id) { course in
                        NavigationLink(destination: CourseDetailView(courseId: course._id)) {
                            ZStack {
                                VStack {
                                    AsyncImage(url: URL(string: course.thumbnail)!) { image in
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
                                                .padding(5)
                                        }

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
                                                Text("\(course.amount + 40000) đ")
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
                                                    Text("\(course.amount + 20000) đ")
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
                }
            }
        }
        .padding(.leading, 10)
    }
}

#Preview {
    TopCoursesView(isLoadingSearchCourse: .constant(false), searchCourses: [SearchCourseModel.sampleData], headerText: HeaderCategoryText.topFreeCourse)
        .backgroundStyle(Color.mainBackgroundColor)
}
