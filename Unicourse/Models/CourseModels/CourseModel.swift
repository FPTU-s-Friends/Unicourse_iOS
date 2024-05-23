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

//// Dùng cho thằng get enrolled
// struct CourseInEnrolledCoursesModel: Codable {
//    var _id: String
//    var type: CourseEnrollType
//    var titleDescription: String
//    var title: String
//    var thumbnail: String
//    var subTitleDescription: [String]
//    var lecture: LectureModel?
//    var subTitle: String
//    var semester_number: Int?
//    var enrollmentCount: Int
// }

// Dùng cho View Detail Model
struct CourseModel: Codable {
    var _id: String
    var title: String
    var titleDescription: String
    var subTitle: String
    var subTitleDescription: [String]
    var enrollmentCount: Int
    var status: String?
    var type: CourseEnrollType
    var thumbnail: String
    var quiz: [QuizModel]?
    var lecture: LectureModel?
    var tracks: [TrackId]?
    var semester_number: Int?

    static var sampleData = CourseModel(_id: "", title: "", titleDescription: "", subTitle: "", subTitleDescription: [""], enrollmentCount: 3, type: .free, thumbnail: "", tracks: [TrackId(_id: "", courseId: "", position: 2, chapterTitle: "", track_steps: [TrackStep(_id: "", title: "", position: 8, duration: 9, content_url: "", type: "")])])
}
