//
//  LectureModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 22/5/24.
//

import Foundation

struct Feedback: Codable {
    var _id: String
    var content: String
    var rating: Int
    var course_id: String?
    var user_id: BasicUserInfo?
    var status: String
}

struct Lecture_Info: Codable {
    var _id: String
//    var my_course: [String]?
//    var my_schedule: [String]
    var description: String?
//    var feedback: [Feedback]?
}

struct LectureModel: Codable {
    var _id: String
    var email: String
    var fullName: String
    var profileName: String
    var profile_image: String
    var dateOfBirth: String?
    var role: UserRole?
    var lecture_info: Lecture_Info?
}
