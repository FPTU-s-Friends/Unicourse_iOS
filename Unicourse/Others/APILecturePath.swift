//
//  APILecturePath.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 30/5/24.
//

import Foundation

enum APILecturePath {
    case getLectureById(lectureId: String)

    var endPointValue: String {
        switch self {
        case .getLectureById(lectureId: let lectureId):
            "/api/lecture/\(lectureId)"
        }
    }
}
