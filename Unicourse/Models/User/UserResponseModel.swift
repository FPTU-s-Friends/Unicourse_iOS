//
//  UserResponseModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

struct requestUpdateUserProfile: Codable {
    var fullName: String
    var profileName: String
    var dateOfBirth: String
    var profile_image: String
}

struct ResponseUpdateUserProfile: Codable {
    var coins: [String]? // Assuming this is a list of strings, you can update the type if needed
    var quizProcess: [String] // Assuming this is a list of strings, you can update the type if needed
    var lectureInfo: String? // This is nullable
    var interests: [String]?
    var recommendedCourses: [String]?
    var deviceToken: [String]?
    var id: String
    var email: String
    var fullName: String
    var profileName: String?
    var dateOfBirth: String? // If you want to use Date type, use DateFormatter to parse this string
    var password: String?
    var enrollCourses: [String]?
    var role: String
    var isCommentBlocked: Bool
    var isBlocked: Bool
    var isChatBlocked: Bool
    var profileImage: String
    var publishedAt: String // If you want to use Date type, use DateFormatter to parse this string
    var createdAt: String // If you want to use Date type, use DateFormatter to parse this string
    var updatedAt: String // If you want to use Date type, use DateFormatter to parse this string
    var version: Int // Typically the version is stored as Int
    var wishList: [String]?
    var quizInterest: [String]?

    // Coding Keys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case coins
        case quizProcess = "quiz_process"
        case lectureInfo = "lecture_info"
        case interests
        case recommendedCourses = "recommended_courses"
        case deviceToken = "device_token"
        case id = "_id"
        case email
        case fullName
        case profileName
        case dateOfBirth
        case password
        case enrollCourses
        case role
        case isCommentBlocked = "is_comment_blocked"
        case isBlocked = "is_blocked"
        case isChatBlocked = "is_chat_blocked"
        case profileImage = "profile_image"
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case version = "__v"
        case wishList = "wish_list"
        case quizInterest = "quiz_interest"
    }
}
