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
    var isLoading: Bool
    var subTitleDescription: [String]
    var subTitle: String
    var courseName: String
    var lecture_id: String

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                // Lecture Info
                LectureInfo(courseAuthorName: courseLectureName, courseRatingPoint: 3.5, totalCourseOfAuthor: 11, courseAuthorBio: lectureDescription, imageLectureURL: imageLectureURL, isLoading: isLoading, lecture_id: lecture_id)
                // Lecture Info
                DetailInformationCourse(isLoadingSkeleton: isLoading, subTitleDescription: subTitleDescription, subTitle: subTitle, courseName: courseName)

                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
}
