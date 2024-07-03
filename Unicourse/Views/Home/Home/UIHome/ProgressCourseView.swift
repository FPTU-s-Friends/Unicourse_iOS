//
//  ProgressView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

import SwiftUI

struct ProgressCourseView: View {
    var listEnrollCourses: [EnrolledCourseModel]
    @Binding var isLoading: Bool

    var body: some View {
        if isLoading {
            VStack {
//                HeaderCategoryView(textCategory: HeaderCategoryText.progressText,
//                                   textButton: TextButton.viewAll,
//                                   action: {})

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0 ..< 3) { _ in
                            SkeletonCourseProgressCard()
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
        } else if isLoading == false && !listEnrollCourses.isEmpty {
            VStack {
                HeaderCategoryView(textCategory: HeaderCategoryText.progressText,
                                   textButton: TextButton.viewAll,
                                   action: {})

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(listEnrollCourses, id: \._id) { enrollCourse in
                            CourseCard(courseItem: enrollCourse)
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
        } else {
            VStack {}
        }
    }
}

#Preview {
    ProgressCourseView(listEnrollCourses: [], isLoading: .constant(false))
}
