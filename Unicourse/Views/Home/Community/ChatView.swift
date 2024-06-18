//
//  ChatView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 18/6/24.
//
import SwiftUI

import Combine

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var inputText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { scrollView in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 8) {
                            ForEach(viewModel.messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding()
                        .onChange(of: viewModel.messages) { _ in
                            if let lastMessageId = viewModel.messages.last?.id {
                                scrollView.scrollTo(lastMessageId, anchor: .bottom)
                            }
                        }
                    }
                }
                .background(Color(UIColor.systemGroupedBackground))

                HStack {
                    ZStack(alignment: .trailing) {
                        TextField("", text: $inputText)
                            .placeholder(when: inputText.isEmpty) {
                                Text("Send a message...")
                                    .foregroundStyle(Color.gray.gradient)
                            }
                            .textFieldStyle(.plain)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 14)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(20)
                            .padding(.horizontal)

                        Button {} label: {
                            Image(systemName: "paperplane.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32)
                                .foregroundStyle(inputText.isEmpty ? Color.gray.gradient : Color.mainColor1.gradient)
                                .padding(.trailing, 25)
                        }
                        .disabled(inputText.isEmpty)
                    }

                    .padding(.bottom, -15)
                }
                .padding(.vertical, 5)
            }
            .navigationTitle("Group Chat 1")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.mainBackgroundColor, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 0.1)
                            )
                            .padding(3)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    })
                }
            }
        }
    }

    private func sendMessage() {
        guard !inputText.isEmpty else { return }
        viewModel.sendMessage(inputText)
        inputText = ""
    }
}

struct MessageBubble: View {
    var message: Message

    var body: some View {
        HStack {
            if message.isSentByCurrentUser {
                Spacer()
                Text(message.text)
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            } else {
                Text(message.text)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
        }
    }
}

#Preview {
    ChatView()
}

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = [
        Message(text: "Hello!", isSentByCurrentUser: false),
        Message(text: "Hi, how are you?", isSentByCurrentUser: true),
        Message(text: "I'm good, thanks!", isSentByCurrentUser: false)
    ]

    func sendMessage(_ text: String) {
        let newMessage = Message(text: text, isSentByCurrentUser: true)
        messages.append(newMessage)
    }
}

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isSentByCurrentUser: Bool
}
