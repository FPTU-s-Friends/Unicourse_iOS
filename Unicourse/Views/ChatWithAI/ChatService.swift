//
//  ChatService.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 14/6/24.
//

import Foundation
import GoogleGenerativeAI
import SwiftUI

enum ChatRole {
    case user
    case model
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    var role: ChatRole
    var message: String
}

@Observable
class ChatService {
    private var chat: Chat?

    private(set) var messages = [ChatMessage]()
    private(set) var loadingResponse = false

    func sendMessage(message: String) async {
        loadingResponse = true

        if chat == nil {
            let history: [ModelContent] = messages.map { ModelContent(role: $0.role == .user ? "user" : "model", parts: $0.message) }
            chat = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default).startChat(history: history)
        }

        messages.append(.init(role: .user, message: message))

        Task {
            do {
                let response = try await chat?.sendMessage(message)

                guard let text = response?.text else {
                    messages.append(.init(role: .model, message: "Something went wrong, please try again."))
                    return
                }

                messages.append(.init(role: .model, message: text))

                loadingResponse = false
            } catch {
                loadingResponse = false
                messages.append(.init(role: .model, message: "Something went wrong, please try again."))
            }
        }
    }
}
