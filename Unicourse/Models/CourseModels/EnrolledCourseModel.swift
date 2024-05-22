//
//  EnrolledCourseModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/5/24.
//

import Foundation



struct BasicUserInfo: Codable {
    var _id: String
    var email: String
    var fullName: String
    var profileName: String
    var profile_image: String
}

// C
struct EnrolledCourseModel: Codable {
    var _id: String
    var user: BasicUserInfo
    var course: CourseInEnrolledCoursesModel
    var completed: Bool
    var enrollDate: String
    var progress: Int
    var trackProgress: [Track]
}
