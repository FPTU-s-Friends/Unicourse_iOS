//
//  ChatService.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 14/6/24.
//

import Foundation
import GoogleGenerativeAI
import SwiftUI

@Observable
class ChatService {
    private var chat: Chat?
    private(set) var messages = [ChatMessage]()
    private(set) var loadingResponse = false

    let suggestionQuestions = [
        "Bạn có thể tóm tắt cho tôi về biến đổi khí hậu không?",
        "Làm thế nào để bắt đầu học lập trình?",
        "Những xu hướng công nghệ mới nhất là gì?",
        "Bạn nghĩ gì về trí tuệ nhân tạo?"
    ]

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

                // Tạo tin nhắn ban đầu (trống)
                messages.append(.init(role: .model, message: ""))

                // Cập nhật tin nhắn theo từng ký tự
                for character in text {
                    if var lastMessage = messages.last { // Kiểm tra xem có tin nhắn cuối không
                        lastMessage.message += String(character) // Cập nhật nội dung
                        messages[messages.count - 1] = lastMessage // Thay thế tin nhắn cuối
                    }
                    try? await Task.sleep(nanoseconds: 50_000_000) // Điều chỉnh thời gian delay nếu cần
                }
            } catch {
                messages.append(.init(role: .model, message: "Something went wrong, please try again."))
            }

            loadingResponse = false
        }
    }
}
