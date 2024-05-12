//
//  UserProfile.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import FirebaseAuth
import Foundation

// Define a struct to represent the user's profile data
struct UserProfile: Equatable {
    var userId: String
    var email: String
    var fullName: String
    var profileImageURL: URL?
    var role: String
    var isCommentBlocked: Bool
    var isBlocked: Bool
    var isChatBlocked: Bool

    init(userId: String, email: String, fullName: String, profileImageURL: URL? = nil, role: String, isCommentBlocked: Bool = false, isBlocked: Bool = false, isChatBlocked: Bool = false) {
        self.userId = userId
        self.email = email
        self.fullName = fullName
        self.profileImageURL = profileImageURL
        self.role = role
        self.isCommentBlocked = isCommentBlocked
        self.isBlocked = isBlocked
        self.isChatBlocked = isChatBlocked
    }
}
