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
    var status: String?
}

struct my_courses_user: Codable {
    var _id: String
    var title: String
    var thumbnail: String
    var semester_number: Int
}

struct Lecture_Info: Codable {
    var _id: String
//    var my_course: [my_courses_user]?
    var description: String?
    var feedback: [Feedback]?
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

    static var sampleData = LectureModel(
        _id: "lecture123",
        email: "lecture@example.com",
        fullName: "John Doe",
        profileName: "johndoe",
        profile_image: "https://example.com/profile.jpg",
        dateOfBirth: "1980-01-01",
        role: .lecture,
        lecture_info: Lecture_Info(
            _id: "lectureinfo123",
            description: "An experienced lecturer in Computer Science."
        )
    )
}
