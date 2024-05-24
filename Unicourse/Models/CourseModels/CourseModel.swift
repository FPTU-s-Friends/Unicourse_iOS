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
    var tracks: [Track]?
    var semester_number: Int?

    static var sampleData = CourseModel(
        _id: "course123",
        title: "Introduction to SwiftUI",
        titleDescription: "Learn the basics of SwiftUI",
        subTitle: "SwiftUI Basics",
        subTitleDescription: ["Overview of SwiftUI", "Building UI with SwiftUI", "State and Data Flow"],
        enrollmentCount: 150,
        status: "Active",
        type: .free,
        thumbnail: "https://example.com/thumbnail.jpg",
        quiz: [QuizModel.sampleData],
        lecture: LectureModel.sampleData,
        tracks: [Track.sampleData],
        semester_number: 1
    )
}
