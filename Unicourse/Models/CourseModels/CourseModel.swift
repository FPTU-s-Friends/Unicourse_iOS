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
    var tracks: [Track]?
    var enrollmentCount: Int
    var status: String?
    var type: CourseEnrollType
    var amount: Int?
    var thumbnail: String
    var quiz: [QuizModel]?
    var lecture: LectureModel?
    var semester_number: Int?
    var created_at: String?
    var updated_at: String?

    static var sampleData = CourseModel(
        _id: "course123",
        title: "Introduction to SwiftUI",
        titleDescription: "Learn the basics of SwiftUI",
        subTitle: "SwiftUI Basics",
        subTitleDescription: ["Overview of SwiftUI", "Building UI with SwiftUI", "State and Data Flow"],
        tracks: [Track.sampleData],
        enrollmentCount: 150,
        status: "Active",
        type: .free,
        thumbnail: "https://example.com/thumbnail.jpg",
        quiz: [QuizModel.sampleData],
        lecture: LectureModel.sampleData,
        semester_number: 1,
        created_at: "2024-05-27T11:21:07.768Z",
        updated_at: "2024-05-27T16:35:15.664Z"
    )
}
