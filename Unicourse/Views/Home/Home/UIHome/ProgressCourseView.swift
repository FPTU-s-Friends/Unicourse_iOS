//
//  ProgressView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct ProgressCourseView: View {
    var listEnrollCourses: [EnrolledCourseModel]
    @Binding var isLoading: Bool

    var body: some View {
        VStack {
            HeaderCategoryView(textCategory: HeaderCategoryText.progressText,
                               textButton: TextButton.viewAll,
                               action: {})

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    if self.isLoading || self.listEnrollCourses.isEmpty {
                        ForEach(0 ..< 3) { _ in
                            SkeletonCourseProgressCard()
                        }
                    } else {
                        ForEach(self.listEnrollCourses, id: \._id) { enrollCourse in
                            CourseCard(courseItem: enrollCourse)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}
