//
//  ChatAIModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/6/24.
//

import Foundation

enum ChatRole {
    case user
    case model
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    var role: ChatRole
    var message: String
}
