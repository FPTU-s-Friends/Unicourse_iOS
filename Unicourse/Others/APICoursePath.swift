//
//  APIUserPath.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/5/24.
//

import Foundation

enum APICoursePath {
    case getEnrolledCourseByUserId(userId: String)
    case getDetailCourseById(courseId: String)
    case enrollNewCourse(courseId: String)

    // API String returned
    var endPointValue: String {
        switch self {
        case .getEnrolledCourseByUserId(userId: let userId):
            "/api/user/\(userId)/get-enrolled-course"
        case .getDetailCourseById(courseId: let courseId):
            "/api/course/\(courseId)"
        case .enrollNewCourse(courseId: let courseId):
            "/api/course/\(courseId)/enroll-course"
        }
    }
}
