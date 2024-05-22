//
//  CourseDetailTabView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/5/24.
//

import SwiftUI

struct CourseDetailTabView: View {
    var courseLectureName: String
    var lectureDescription: String
    var imageLectureURL: String
    var body: some View {
        VStack(spacing: 10) {
            // Lecture Info
            LectureInfo(courseAuthorName: courseLectureName, courseRatingPoint: 3.5, totalCourseOfAuthor: 11, courseAuthorBio: lectureDescription, imageLectureURL: imageLectureURL)
            // Lecture Info
            DetailInformationCourse()

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
