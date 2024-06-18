//
//  APIQuiz.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 3/6/24.
//

import Foundation

enum APIQuizPath {
    case getQuizById(quizId: String)
    case calculateQuizResult(userId: String)

    var endPointValue: String {
        switch self {
        case .getQuizById(quizId: let quizId):
            "/api/quiz/\(quizId)"
        case .calculateQuizResult(userId: let userId):
            "/api/quiz/result/\(userId)"
        }
    }
}
