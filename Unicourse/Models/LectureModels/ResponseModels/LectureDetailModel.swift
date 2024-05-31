//
//  LectureDetailModels.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 30/5/24.
//

import Foundation

struct Lecture_Feedback: Codable {
    let _id: String
    let content: String
    let rating: Int
}

struct My_Schedule_Detail: Codable {}

struct My_Course_Detail: Codable {
    let _id: String
    let title: String
    let thumbnail: String
    let semester_number: Int
}

struct LectureInfoDetail: Codable {
    let _id: String
    let my_course: [My_Course_Detail]
    let my_schedule: [My_Schedule_Detail]?
    let feedback: [Lecture_Feedback]
    let description: String
}

struct LectureDetailModel: Codable {
    let _id: String
    let email: String
    let fullName: String
    let profileName: String
    let dateOfBirth: String
    let role: String
    let profile_image: String
}
