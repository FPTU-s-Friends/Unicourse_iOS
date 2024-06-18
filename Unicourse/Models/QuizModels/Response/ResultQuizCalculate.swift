//
//  ResultQuizCalculate.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 18/6/24.
//

import Foundation

struct QuestionResponseResult: Codable {
    var _id: String
    var title: String
    var type: Type_Question
    var is_answered: Bool
    var answer: [AnswerRequest]
    var user_correct: Bool
}

struct ResultQuizCalculate: Codable {
    var _id: String
    var title: String
    var description: String
    var picture: String
    var course_id: String?
    var questions: [QuestionResponseResult]
    var status: String
    var category: String
    var creator_id: Creator
    var viewer: Int
    var creator_role: String
    var number_right_answer: Int
}
