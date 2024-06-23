//
//  APIPath.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Foundation

enum APIPath {
    case signIn
    case signUp
    case getUsers
    case getUserInfo
    case getAllFreeCourse
    case getCourseSemester
    case searchCourse
    case getQuiz
    case getBanners
    case getBlogs
    case getHighlightBlog
    case likeBlog
    case unlikeBlog
    case comment
    case likeAndUnlikeComment
    case replyComment
    case getUserCart
    case addToCart
    case getTransactionHistory
    case updateUser
    case getChatRooms

    var stringValue: String {
        switch self {
        case .signIn:
            "/api/auth/signIn"
        case .signUp:
            "/api/auth/signUp"
        case .getUserInfo:
            "/api/user"
        case .getAllFreeCourse:
            "/api/course/free-course"
        case .getCourseSemester:
            "/api/course/semester"
        case .getUsers:
            "/api/user/get-all-users"
        case .searchCourse:
            "/api/common/search"
        case .getQuiz:
            "/api/quiz/interest"
        case .getBanners:
            "/api/banner"
        case .getBlogs:
            "/api/blog"
        case .getHighlightBlog:
            "/api/blog/highlight"
        case .likeBlog:
            "/api/blog/like-blog"
        case .unlikeBlog:
            "/api/blog/unlike-blog"
        case .comment:
            "/api/comment"
        case .likeAndUnlikeComment:
            "/api/comment/like_or_unlike"
        case .replyComment:
            "/api/comment/reply"
        case .getUserCart:
            "/api/cart/retrieve-user-cart"
        case .getTransactionHistory:
            "/api/transactions/user"
        case .addToCart:
            "/api/cart/add-to-cart"
        case .updateUser:
            "/api/user/updateUserLevel"
        case .getChatRooms:
            "/api/chatRoom/get-room"
        }
    }
}
