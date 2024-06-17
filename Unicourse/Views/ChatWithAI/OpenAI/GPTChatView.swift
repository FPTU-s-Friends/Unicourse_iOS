//
//  GPTChatView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/6/24.
//

import SwiftUI

struct GPTChatView: View {
    // Chat messages
    @State private var chatMessages: [ChatMessageOpenAI] = []
    // Text input
    @State private var messageText: String = "Hello"

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(chatMessages) { chatMessage in
                        MessageView(chatMessage: chatMessage)
                    }
                }
            }
            .padding()

            HStack {
                TextField("Enter a message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: sendMessage) {
                    Text("Send")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .padding()
        }
    }

    private func sendMessage() {
        // Check if message text is not empty
        guard !messageText.isEmpty else {
            return
        }

        // Create a new chat message
        let newMessage = ChatMessageOpenAI(content: messageText, sender: .user, dateCreated: Date())

        // Add the message to chat messages
        chatMessages.append(newMessage)

        // Clear the message text
        messageText = ""

        // TODO: Send message to OpenAI API and receive response
    }
}

struct MessageView: View {
    let chatMessage: ChatMessageOpenAI

    var body: some View {
        VStack {
            Text(chatMessage.content)
                .padding()
                .foregroundColor(.white)
                .background(chatMessage.sender == .user ? Color.blue : Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)

            HStack {
                if chatMessage.sender == .user {
                    Spacer()
                }

                Text(chatMessage.dateCreated.timeAgo())
                    .font(.caption)
            }
            .padding(.horizontal)
        }
    }
}

extension Date {
    func timeAgo() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

#Preview {
    GPTChatView()
}

struct ChatMessageOpenAI: Identifiable {
    let id = UUID() // Unique identifier for each message
    let content: String
    let sender: Sender
    let dateCreated: Date

    enum Sender {
        case user
        case assistant
    }

    init(content: String, sender: Sender, dateCreated: Date = Date()) {
        self.content = content
        self.sender = sender
        self.dateCreated = dateCreated
    }
}
