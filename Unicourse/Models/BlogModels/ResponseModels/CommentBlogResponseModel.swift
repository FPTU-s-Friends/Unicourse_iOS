//
//  CommentBlogResponseModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 4/6/24.
//

import Foundation

struct CommentBlogResponseModel: Codable {
    let _id: String
    let comment: String
    let commentator: String
    let replies: [RepliesBlogModel]?
    let interactions: [String]?
    let created_at: String
    let updated_at: String
    let is_removed: Bool
    let is_approved: Bool
}
