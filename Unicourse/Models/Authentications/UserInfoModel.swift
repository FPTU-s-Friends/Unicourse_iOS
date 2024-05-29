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
}

struct EnrollCourseUserInfo: Codable {
    let _id: String
    let courseId: EnrollCourseNonDetail
    let completed: Bool
    let enrollDate: String
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
    let enrollCourses: [EnrollCourseUserInfo]? // Assuming course IDs are strings
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
    let wishList: [WisListUserInfo]? // chỉnh sửa sau

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
