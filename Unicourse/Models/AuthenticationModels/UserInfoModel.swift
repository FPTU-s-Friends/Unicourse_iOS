//
//  UserInfoModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 28/5/24.
//

import Foundation

struct UserInfoLectureCourseModel: Codable {
    let _id: String
    let fullName: String
    let profileName: String?
    let profile_image: String

    static let sampleData = UserInfoLectureCourseModel(_id: "662f61f6b57741e90fac0a5b",
                                                       fullName: "Giảng viên Unicourse",
                                                       profileName: "",
                                                       profile_image: "https://lh3.googleusercontent.com/a/ACg8ocLzW-T4UHAYsYHdEUvPk9ukeshyAZpPbTHHpva5ndCUGFNUlw=s96-c")
}

struct EnrollCourseNonDetail: Codable {
    let _id: String
    let title: String
    let titleDescription: String
    let amount: Int
    let thumbnail: String
    let lecture: UserInfoLectureCourseModel

    static let sampleData = EnrollCourseNonDetail(_id: "65a8790ba30979a347d026c9",
                                                  title: "Khóa học CSI104",
                                                  titleDescription: "Kiến thức của bài giảng của khóa CSI101",
                                                  amount: 0,
                                                  thumbnail: "https://anhcocvang.com/static/media/CSI104.2184a7868fa678077f03.png",
                                                  lecture: UserInfoLectureCourseModel.sampleData)
}

struct EnrollCourseUserInfo: Codable {
    let _id: String
    let courseId: EnrollCourseNonDetail
    let completed: Bool
    let enrollDate: String

    static let sampleData = EnrollCourseUserInfo(_id: "66514f71d51b1f8bc799391b",
                                                 courseId: EnrollCourseNonDetail.sampleData,
                                                 completed: false,
                                                 enrollDate: "2024-05-24T17:21:40.302Z")
}

struct WisListUserInfo: Codable {
    let _id: String
    let title: String
    let titleDescription: String
    let amount: Int
    let thumbnail: String
    let lecture: UserInfoLectureCourseModel
    let semester_number: Int

    static let sampleData = WisListUserInfo(_id: "",
                                            title: "",
                                            titleDescription: "",
                                            amount: 0,
                                            thumbnail: "",
                                            lecture: UserInfoLectureCourseModel.sampleData,
                                            semester_number: 2)
}

struct UserInfoModel: Codable {
    let _id: String
    let email: String
    let fullName: String
    let profileName: String?
    let dateOfBirth: String?
    let enrollCourses: [EnrollCourseUserInfo]?
    let role: UserRole
    let isCommentBlocked: Bool
    let isBlocked: Bool
    let isChatBlocked: Bool
    let profileImage: String
    let publishedAt: String?
    let userClass: Int
    let coins: [coinsUserInfoModel]? // chỉnh sửa sau
    let quizInterest: [String]? // chỉnh sửa sau
    let quizProcess: [String]? // chỉnh sửa sau
    let lectureInfo: LectureModel?
    let wishList: [WisListUserInfo]?

    enum CodingKeys: String, CodingKey, Codable {
        case _id
        case email
        case fullName
        case profileName
        case dateOfBirth
        case enrollCourses
        case role
        case isCommentBlocked = "is_comment_blocked"
        case isBlocked = "is_blocked"
        case isChatBlocked = "is_chat_blocked"
        case profileImage = "profile_image"
        case publishedAt = "published_at"
        case userClass = "class"
        case coins
        case quizInterest = "quiz_interest"
        case quizProcess = "quiz_process"
        case lectureInfo = "lecture_info"
        case wishList = "wish_list"
    }
}

struct coinsUserInfoModel: Codable {
    let _id: String
    let title: String
    let description: String
    let coin: Int
    let type: String
    let date_used: String?
    let status: String // Chỉnh sửa sau
}
