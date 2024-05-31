//
//  TopFreeCourseView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 30/5/24.
//

import SwiftUI

struct TopFreeCourseView: View {
    @Binding var isLoadingSearchCourse: Bool
    @State private var isNavigateToAllFreeCourse = false
    var freeCourse: [SearchCourseModel]
    var headerText: String

    var body: some View {
        HeaderCategoryView(textCategory: headerText,
                           textButton: TextButton.viewMore,
                           action: {
                               isNavigateToAllFreeCourse = true
                           })
                           .navigationDestination(isPresented: $isNavigateToAllFreeCourse) {
                               AllFreeCoursesView()
                           }

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if self.isLoadingSearchCourse || self.freeCourse.isEmpty {
                    ForEach(0 ..< 3) { _ in
                        SkeletonCourseProgressCard()
                    }
                } else {
                    ForEach(freeCourse, id: \._id) { course in
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
    TopFreeCourseView(isLoadingSearchCourse: .constant(false), freeCourse: [SearchCourseModel.sampleData], headerText: HeaderCategoryText.topFreeCourse)
        .backgroundStyle(Color.mainBackgroundColor)
}
