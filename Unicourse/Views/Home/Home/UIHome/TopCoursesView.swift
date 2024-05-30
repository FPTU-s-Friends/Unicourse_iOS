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
                        NavigationLink(destination: CourseDetailView(courseId: course._id)) {
                            TopCourseViewItem(course: course)
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
