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

struct CourseModel: Codable {
    var _id: String
    var type: CourseEnrollType
    var titleDescription: String
    var title: String
    var thumbnail: String
    var subTitleDescription: [String]
    var subTitle: String
    var semester_number: Int?
    var enrollmentCount: Int
}
