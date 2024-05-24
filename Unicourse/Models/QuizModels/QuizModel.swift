//
//  QuizModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 22/5/24.
//

import Foundation

enum StatusQuiz: String, Codable {
    case open
    case closed
}

enum CreatorRole: String, Codable {
    case lecture
    case student
}

struct QuizModel: Codable {
    var _id: String
    var title: String
    var description: String
    var course_id: String
    var status: StatusQuiz
    var max_attemps: Int?
    var passing_score: Int?
    var category: String
    var viewer: Int
    var creator_role: CreatorRole
    var creator_id: String

    static var sampleData = QuizModel(
        _id: "quiz123",
        title: "SwiftUI Basics Quiz",
        description: "A quiz to test your knowledge of SwiftUI basics.",
        course_id: "course123",
        status: .open,
        max_attemps: 3,
        passing_score: 70,
        category: "Programming",
        viewer: 120,
        creator_role: .lecture,
        creator_id: "creator123"
    )
}
