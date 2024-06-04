//
//  DetailBlogModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import Foundation

struct DetailBlogModel: Codable {
    let _id: String
    let title: String
    let description: String
    let min_read: Int
    let images: [String]
    let date_modified: String?
    let thumbnail_url: String
    let comment_obj: [Comment_objModel]
    let content: String
    let tags: [BlogTag]
    let status: String
    let flag: Bool
    let like: [String]
    let date_published: String
    let userId: BlogUserModel
    let created_at: String
    let updated_at: String
}

struct Comment_objModel: Codable {
    let _id: String
    let comment: String
    let commentator: BlogCommentatorModel
    let replies: [RepliesBlogModel]
    let interactions: [String]
    let created_at: String

    static let sampleCommentData: Comment_objModel = .init(
        _id: "662e3998f9ea647f958e00fe",
        comment: "<p>Em cũng dân IT mà giờ mông lung quá mấy bác :(</p>",
        commentator: BlogCommentatorModel(
            _id: "65bded46ccbed6413a0b128f",
            email: "datntse150392@fpt.edu.vn",
            fullName: "Nguyễn Thành Đạt ",
            profileName: "", // No profile name provided
            profile_image: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/images%2Fdownload.jpg?alt=media&token=27ffa58c-b776-4f6a-9492-9e48bb71e008"
        ),
        replies: [], // Empty array for replies, as none were provided
        interactions: [
            "65bded46ccbed6413a0b128f",
            "6635bf84ee82faada12a9fb2"
        ],
        created_at: "2024-04-28T11:57:12.707Z"
    )
}

struct RepliesBlogModel: Codable {
    let _id: String
    let comment: String
    let commentator: BlogCommentatorModel
    let interactions: [String]
    let created_at: String

    static let sampleReplyData: RepliesBlogModel = .init(
        _id: "reply123",
        comment: "<p>Đừng nản, cơ hội vẫn còn nhiều lắm!</p>",
        commentator: BlogCommentatorModel(
            _id: "anotherUser123",
            email: "anotheruser@example.com",
            fullName: "Another User",
            profileName: "CoderPro",
            profile_image: "https://example.com/profile.jpg" // Replace with valid URL
        ),
        interactions: ["anotherUser123", "user456"],
        created_at: "2024-05-01T08:30:00Z"
    )
}

struct BlogCommentatorModel: Codable {
    let _id: String
    let email: String
    let fullName: String
    let profileName: String
    let profile_image: String
}
