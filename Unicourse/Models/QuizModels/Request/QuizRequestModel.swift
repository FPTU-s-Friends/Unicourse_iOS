//
//  QuizRequestModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 4/6/24.
//

import Foundation

struct AnswerRequest: Codable, Equatable
{
    var id: String { answer_text }
    var answer_text: String
    var is_correct: Bool
    var is_checked: Bool
    var is_answered: Bool

    static var mockData = AnswerRequest(answer_text: "", is_correct: false, is_checked: false, is_answered: false)
}

struct QuestionRequest: Codable
{
    var _id: String
    var title: String
    var type: Type_Question
    var is_answered: Bool
    var answer: [AnswerRequest]
}

struct QuizRequestModel: Codable
{
    var _id: String
    var title: String
    var description: String
    var picture: String
    var course_id: String?
    var questions: [QuestionRequest]
    var status: String
    var category: String
    var creator_id: Creator
    var viewer: Int
    var creator_role: String
}
