//
//  SearchCourseModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 24/5/24.
//

import Foundation

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

struct SearchCourseResponseModel: Codable {
    var course: [SearchCourseModel]
}
