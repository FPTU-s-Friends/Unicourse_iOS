//
//  CourseDetailTabView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/5/24.
//

import SwiftUI

struct CourseDetailTabView: View {
    var body: some View {
        VStack(spacing: 10) {
            // Lecture Info
            LectureInfo(courseAuthorName: "Nguyễn Trung Kiên", courseRatingPoint: 3.5, totalCourseOfAuthor: 11, courseAuthorBio: "Thiết kế không chỉ là trông nó như thế nào và cảm thấy như thế nào. Thiết kế là cách nó hoạt động")
            // Lecture Info
            DetailInformationCourse()

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
