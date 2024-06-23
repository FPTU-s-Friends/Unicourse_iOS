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
    var enrollmentCount: Int
    var type: CourseEnrollType
    var amount: Int
    var thumbnail: String
    var lecture: SearchCourseLectureModel

    static var sampleData = SearchCourseModel(
        _id: "65a9f5c319080610bf831c55",
        title: "Khóa học CEA201",
        titleDescription: "Kiến thức các bài giảng của khóa CEA201",
        enrollmentCount: 10,
        type: .free,
        amount: 0,
        thumbnail: "https://anhcocvang.com/static/media/CEA201.726e8249a187ad5531b6.png",
        lecture: SearchCourseLectureModel.sampleData
    )
}

struct SearchCourseLectureModel: Codable {
    var _id: String
    var fullName: String
    var profileName: String?
    var profile_image: String

    static var sampleData = SearchCourseLectureModel(_id: "662f61f6b57741e90fac0a5b",
                                                     fullName: "Giảng viên Unicourse",
                                                     profile_image: "https://lh3.googleusercontent.com/a/ACg8ocLzW-T4UHAYsYHdEUvPk9ukeshyAZpPbTHHpva5ndCUGFNUlw=s96-c")
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

    static let sampleData = QuizSearchModel(_id: "663cbe6bc8497fc91aa9066c",
                                            title: "SSG104 - Part 1",
                                            description: "Mã môn học SSG104 - Phần 1",
                                            picture: "https://apollo.primeng.org/assets/demo/images/blog/blog-2.png",
                                            status: "open",
                                            category: "CN2")
}

// Blog Search Model
struct BlogSearchModel: Codable {
    var _id: String
    var title: String
    var description: String
    var min_read: Int
    var images: [String]?
    var thumbnail_url: String?
    var tags: [Tag]
    var status: String
    var date_published: String

    // Dữ liệu mẫu cho BlogSearchModel
    static let sampleData =
        BlogSearchModel(
            _id: "65af6fd2f5cdb60fc506c592",
            title: "Rèn luyện tư duy và áp dụng kiến thức đã học vào thực hành",
            description: "Bài viết này sẽ chia sẻ cho các bạn vài típ về cân bằng giữa việc học và thực hành trong lập trình",
            min_read: 2,
            images: [
                "https://firebasestorage.googleapis.com/v0/b/nha-trang-ntne.appspot.com/o/Unicourse%20Project%2Fblog2.jpg?alt=media&token=4b470754-8de9-43ab-8bca-2a7be3fbaf17"
            ],
            thumbnail_url: "https://firebasestorage.googleapis.com/v0/b/nha-trang-ntne.appspot.com/o/Unicourse%20Project%2Fblog2.jpg?alt=media&token=4b470754-8de9-43ab-8bca-2a7be3fbaf17",
            tags: [
                Tag(name: "Thuật toán", code: "thuat_toan", color: "#CCCCCC"),
                Tag(name: "Cơ bản", code: "co_ban", color: "#336699")
            ],
            status: "approved",
            date_published: "2024-01-22T00:00:00.000Z"
        )
}

struct Tag: Codable {
    var name: String
    var code: String
    var color: String
}
