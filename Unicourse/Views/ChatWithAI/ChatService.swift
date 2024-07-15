//
//  ChatService.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 14/6/24.
//

import Foundation
import GoogleGenerativeAI
import SwiftUI

@available(iOS 16.0, *)
class ChatService: ObservableObject {
    private var chat: Chat?
    @Published private(set) var messages = [ChatMessage]()
    @Published private(set) var messagesOpenAI = [ChatMessage]()
    @Published private(set) var loadingResponse = false

    let suggestionQuestions = [
        "Bạn có thể tóm tắt cho tôi về biến đổi khí hậu không?",
        "Làm thế nào để bắt đầu học lập trình?",
        "Những xu hướng công nghệ mới nhất là gì?",
        "Bạn nghĩ gì về trí tuệ nhân tạo?"
    ]

    func sendMessage(message: String) async {
        DispatchQueue.main.async {
            self.loadingResponse = true
        }

        if chat == nil {
            let history: [ModelContent] = messages.map { ModelContent(role: $0.role == .user ? "user" : "model", parts: $0.message) }
            chat = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default).startChat(history: history)
        }

        DispatchQueue.main.async {
            self.messages.append(.init(role: .user, message: message))
        }

        Task {
            do {
                let response = try await chat?.sendMessage(message)
                guard let text = response?.text else {
                    DispatchQueue.main.async {
                        self.messages.append(.init(role: .model, message: "Something went wrong, please try again."))
                    }
                    return
                }

                // Tạo tin nhắn ban đầu (trống)
                DispatchQueue.main.async {
                    self.messages.append(.init(role: .model, message: ""))
                }

                // Cập nhật tin nhắn theo từng ký tự
                for character in text {
                    DispatchQueue.main.async {
                        if var lastMessage = self.messages.last { // Kiểm tra xem có tin nhắn cuối không
                            lastMessage.message += String(character) // Cập nhật nội dung
                            self.messages[self.messages.count - 1] = lastMessage // Thay thế tin nhắn cuối
                        }
                    }
                    try? await Task.sleep(nanoseconds: 50_000_000) // Điều chỉnh thời gian delay nếu cần
                }
            } catch {
                DispatchQueue.main.async {
                    self.messages.append(.init(role: .model, message: "Something went wrong, please try again."))
                }
            }

            DispatchQueue.main.async {
                self.loadingResponse = false
            }
        }
    }
}
