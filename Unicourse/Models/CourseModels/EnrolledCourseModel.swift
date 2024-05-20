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

// Continuing
struct EnrolledCourseModel: Codable {
    var _id: String
    var completed: Bool
    var enrollDate: Date
    var course: CourseModel
    var progress: Int
    var user: BasicUserInfo
}
