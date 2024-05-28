//
//  TopCoursesView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct TopCoursesView: View {
    var searchCourses: [SearchCourseModel]
    @Binding var isLoadingSearchCourse: Bool
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
                                ZStack(alignment: .topTrailing) {
                                    AsyncImage(url: URL(string: course.thumbnail)!) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)

                                    } placeholder: {
                                        ProgressView()
                                    }

                                    VStack {
                                        Text("Hot")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(.red.gradient)
                                            .padding(5)
                                            .padding(.horizontal, 10)
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(20)
                                    }
                                    .padding(.top, 10)
                                    .padding(.trailing, 10)
                                }

                                VStack(alignment: .leading) {
                                    Spacer()
                                    HStack {
                                        Image(.user)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20)

                                        Text(course.lecture.fullName)
                                            .font(.system(size: 12, weight: .bold))
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(1)
                                            .frame(maxWidth: 100)
                                            .foregroundStyle(.black)
                                            .padding(6)
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(10)

                                        Spacer()

                                        Text("\(course.type == .free ? "Free" : "Paid")")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(course.type == CourseEnrollType.free ? Color.green.gradient : Color.blue.gradient)
                                            .padding(5)
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(10)
                                    }

                                    Text(course.title)
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                }
                                .padding(10)
                            }
                            .frame(width: 270)
                            .cornerRadius(20)
                            .padding(.leading, 10)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TopCoursesView(searchCourses: [], isLoadingSearchCourse: .constant(true), headerText: HeaderCategoryText.topFreeCourse)
}
