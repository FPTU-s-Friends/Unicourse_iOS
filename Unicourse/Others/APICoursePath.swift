//
//  APIUserPath.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/5/24.
//

import Foundation

enum APIUserPath {
    case getEnrolledCourseByUserId(userId: String)
    // API
    var endPointValue: String {
        switch self {
        case .getEnrolledCourseByUserId(userId: let userId):
            "/api/user/\(userId)/get-enrolled-course"
        }
    }
}
