//
//  APIPath.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Foundation

enum APIPath {
    case signIn
    case signUp
    case getAllFreeCourse

    var stringValue: String {
        switch self {
        case .signIn:
            "/api/auth/signIn"
        case .signUp:
            "/api/auth/signUp"
        case .getAllFreeCourse:
            "/api/course/free-course"
        }
    }
}
