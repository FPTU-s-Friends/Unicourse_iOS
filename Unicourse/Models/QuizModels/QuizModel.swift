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
}
