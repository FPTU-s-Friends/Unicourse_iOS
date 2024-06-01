//
//  BlogModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/6/24.
//

import Foundation

struct BlogModel: Codable {
    let _id: String
    let title: String
    let description: String
    let min_read: Int
    let images: [String]
    let date_modified: String?
    let thumbnail_url: String
    let comment_obj: [String]
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

struct BlogTag: Codable {
    let name: String
    let code: String
    let color: String
}

struct BlogUserModel: Codable {
    let _id: String
    let email: String
    let fullName: String
    let profileName: String
    let profile_image: String
}
