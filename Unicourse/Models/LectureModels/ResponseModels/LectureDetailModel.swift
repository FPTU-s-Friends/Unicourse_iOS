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

    static var sample_data: [My_Course_Detail] = [
        My_Course_Detail(_id: "1", title: "Khoá học JPD113", thumbnail: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Course%2FCN3%2FJPD133.png?alt=media&token=c028ceac-c738-4a48-a862-acbeebc2d0cf", semester_number: 4),
        My_Course_Detail(_id: "2", title: "Khoá học MAS291", thumbnail: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Course%2FCN4%2FMAS291.png?alt=media&token=7d75d787-d81a-418a-8a60-d5507e9ec8e7", semester_number: 4),
        My_Course_Detail(_id: "3", title: "Khóa học IOT102 - Kỳ Spring 2022", thumbnail: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Course%2FCN4%2FIOT102.png?alt=media&token=edc4d1f1-daff-4f28-b37b-8c03afa533b2", semester_number: 4)
    ]
}

struct LectureInfoDetail: Codable {
    let _id: String
    let my_course: [My_Course_Detail]?
    let my_schedule: [My_Schedule_Detail]?
    let feedback: [Lecture_Feedback]
    let description: String
}

struct LectureDetailModel: Codable {
    let _id: String
    let email: String
    let fullName: String
    let profileName: String
    let dateOfBirth: String?
    let role: String
    let profile_image: String
    let lecture_info: LectureInfoDetail?
}
