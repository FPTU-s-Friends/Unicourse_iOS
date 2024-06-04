//
//  CommentBlogRequest.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 4/6/24.
//

import Foundation

struct CommentBlogRequestModel: Encodable {
    let blogId: String
    let comment: String
}

struct LikeUnLikeCommentBlogRequestModel: Encodable {
    let commentId: String
}
