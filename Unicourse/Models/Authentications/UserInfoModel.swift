//
//  UserInfoModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 28/5/24.
//

import Foundation

struct EnrollCourseNonDetail: Codable {
    let _id: String
    let title: String
    let titleDescription: String
    let thumbnail: String

    static let sampleData = EnrollCourseNonDetail(_id: "65a8790ba30979a347d026c9",
                                                  title: "Khóa học CSI104",
                                                  titleDescription: "Kiến thức của bài giảng của khóa CSI101",
                                                  thumbnail: "https://anhcocvang.com/static/media/CSI104.2184a7868fa678077f03.png")
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
    let thumbnail: String
    let semester_number: Int
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
    let coins: [String]? // chỉnh sửa sau
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
