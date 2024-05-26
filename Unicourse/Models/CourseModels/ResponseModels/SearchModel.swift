//
//  SearchCourseModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 24/5/24.
//

import Foundation

// Main Model
struct SearchResponseModel: Codable {
    var course: [SearchCourseModel]
    var quiz: [QuizSearchModel]
    var blog: [BlogSearchModel]
}

// Course Search Model
struct SearchCourseModel: Codable {
    var _id: String
    var title: String
    var titleDescription: String
    var type: CourseEnrollType
    var thumbnail: String

    static var sampleData = SearchCourseModel(
        _id: "65a9f5c319080610bf831c55",
        title: "Khóa học CEA201",
        titleDescription: "Kiến thức các bài giảng của khóa CEA201",
        type: .free,
        thumbnail: "https://anhcocvang.com/static/media/CEA201.726e8249a187ad5531b6.png"
    )
}

// Quiz Search Model
struct QuizSearchModel: Codable {
    var _id: String
    var title: String
    var description: String
    var picture: String
    var course_id: String?
    var status: String
    var category: String
}

// Blog Search Model
struct BlogSearchModel: Codable {
    var _id: String
    var title: String
    var description: String
    var min_read: Int
    var images: [String]?
    var thumbnail_url: String?
    var tags: [tag]
    var status: String
    var date_published: String
}

struct tag: Codable {
    var name: String
    var code: String
    var color: String
}
