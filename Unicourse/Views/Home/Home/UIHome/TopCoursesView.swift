//
//  TopCoursesView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct TopCoursesView: View {
    @Namespace var nameSpace
    @Binding var isLoadingSearchCourse: Bool
    @State private var isNavigateToAllTopCourse = false
    var searchCourses: [SearchCourseModel]
    var headerText: String

    var body: some View {
        HeaderCategoryView(textCategory: headerText,
                           textButton: TextButton.viewMore,
                           action: {
                               isNavigateToAllTopCourse = true
                           })
                           .navigationDestination(isPresented: $isNavigateToAllTopCourse) {
                               AllTopCourseView()
                           }

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if self.isLoadingSearchCourse || self.searchCourses.isEmpty {
                    ForEach(0 ..< 3) { _ in
                        SkeletonCourseProgressCard()
                    }
                } else {
                    ForEach(searchCourses, id: \._id) { course in
                        NavigationLink {
                            if #available(iOS 18.0, *) {
                                CourseDetailView(courseId: course._id)
                                    .navigationTransition(.zoom(sourceID: "card\(course._id)", in: nameSpace))

                            } else {
                                CourseDetailView(courseId: course._id)
                            }
                        } label: {
                            if #available(iOS 18.0, *) {
                                TopCourseViewItem(course: course)
                                    .matchedTransitionSource(id: "card\(course._id)", in: nameSpace)
                                    .cornerRadius(20)
                            } else {
                                TopCourseViewItem(course: course)
                                    .cornerRadius(20)
                            }
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
