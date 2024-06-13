//
//  GeminiPromptView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 13/6/24.
//

import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool // Determines whether the message is from the user or AI
}

struct GeminiPromptView: View {
    @State private var messages: [ChatMessage] = []
    @State private var inputText: String = ""
    @State private var isBreathing = false

    var body: some View {
        NavigationView {
            VStack {
                Image("geminiIcon")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaleEffect(isBreathing ? 1.4 : 1.0)
                    .animation(Animation.easeInOut(duration: 1.4).repeatForever(autoreverses: true), value: isBreathing)
                    .onAppear {
                        isBreathing = true
                    }
                    .padding()
                // Display messages
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                        }
                    }
                    .padding()
                }

                // Message input bar
                HStack {
                    TextField("Type a message", text: $inputText)
                        .padding()
                        .background(Color.mainColor3)
                        .cornerRadius(15)
                        .shadow(radius: 2)
                        .font(.system(size: 14, weight: .semibold))
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .padding(10)
                            .foregroundStyle(Color.mainColor1.gradient, Color.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                }
                .padding()
            }
            .navigationTitle("Unicourse 🤖")
            .navigationBarTitleDisplayMode(.inline)
            .background {
                Color.mainBackgroundColor
                    .ignoresSafeArea()
            }
        }
    }

    func sendMessage() {
        guard !inputText.isEmpty else { return }
        let newMessage = ChatMessage(text: inputText, isUser: true)
        messages.append(newMessage)
        inputText = "" // Clear the input field after sending

        // Send the message to the ChatGPT API (handle this part)
        // After receiving the response, append the AI's message to messages
    }
}

struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser {
                Spacer() // Push user messages to the right
            }
            Text(message.text)
                .padding()
                .background(message.isUser ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 2)
            if !message.isUser {
                Spacer() // Push AI messages to the left
            }
        }
        .padding(message.isUser ? .trailing : .leading, 16)
    }
}

#Preview {
    GeminiPromptView()
}
