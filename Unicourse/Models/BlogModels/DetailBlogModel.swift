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
}

struct RepliesBlogModel: Codable {
    let _id: String
    let comment: String
    let commentator: BlogCommentatorModel
    let interactions: [String]
    let created_at: String
}

struct BlogCommentatorModel: Codable {
    let _id: String
    let email: String
    let fullName: String
    let profileName: String
    let profile_image: String
}
