//
//  CourseModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/5/24.
//

import Foundation

enum CourseEnrollType: String, Codable {
    case fee
    case free
}

struct CourseInEnrolledCoursesModel: Codable {
    var _id: String
    var type: CourseEnrollType
    var titleDescription: String
    var title: String
    var thumbnail: String
    var subTitleDescription: [String]
    var subTitle: String
    var semester_number: Int?
    var enrollmentCount: Int
}

struct CourseDetailModel: Codable {
    var _id: String
    var title: String
    var titleDescription: String
    var subTitle: String
    var subTitleDescription: [String]
    var enrollmentCount: Int
    var status: Bool
    var type: CourseEnrollType
    var thumbnail: String
    var quiz: [QuizModel]?
    var lecture: [LectureModel]
    var tracks: [TrackId]
    var semester_number: Int?
}
