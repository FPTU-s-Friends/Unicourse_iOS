//
//  ProgressView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct ProgressCourseView: View {
    var listEnrollCourses: [EnrolledCourseModel]

    var body: some View {
        HeaderCategoryView(textCategory: "Tiến trình",
                           textButton: "Tất cả",
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
}

#Preview {
    ProgressCourseView(listEnrollCourses: [])
}
