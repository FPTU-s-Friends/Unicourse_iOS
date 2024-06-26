//
//  GeminiPromptView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 13/6/24.
//

import GoogleGenerativeAI
import PhotosUI
import SDWebImageSwiftUI
import SwiftUI

struct GeminiPromptView: View {
    @State private var textInput = ""
    @State private var chatService = ChatService()
    @State var timer: Timer?
    @State private var showSuggestions = true
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var isAnimating = false
    @Binding var isOpenGemini: Bool

    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(chatService.messages) { message in
                            chatMessageView(message)
                        }
                    }
                    .onChange(of: chatService.messages) { _, _ in
                        guard let recentMessage = chatService.messages.last else { return }
                        DispatchQueue.main.async {
                            withAnimation {
                                proxy.scrollTo(recentMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.top, 20)

                if chatService.loadingResponse {
                    Image("geminiIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .scaleEffect(isAnimating ? 1.3 : 1.0)
                        .opacity(isAnimating ? 1.0 : 0.6)
                        .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isAnimating)
                        .scaleEffect(isAnimating ? 1.3 : 1.0)
                        .opacity(isAnimating ? 1.0 : 0.6)
                        .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isAnimating)
                        .padding()
                        .onAppear { isAnimating = true }
                }

                if showSuggestions {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) { // Thêm khoảng cách giữa các nút
                            ForEach(chatService.suggestionQuestions, id: \.self) { question in
                                Button(action: {
                                    Task {
                                        await chatService.sendMessage(message: question)
                                        showSuggestions = false
                                    }

                                }) {
                                    VStack {
                                        Text(question)
                                            .font(.system(size: 12, weight: .light))
                                            .foregroundStyle(Color.mainColor1.gradient)
                                            .foregroundStyle(Color.mainColor1.gradient)
                                            .frame(width: 100, height: 60, alignment: .topLeading)
                                            .padding() // Thêm padding
                                            .background(
                                                RoundedRectangle(cornerRadius: 10) // Bo góc
                                                    .fill(Color.white.gradient) // Màu xám
                                            )
                                    }
                                }
                            }
                        }
                        .padding(.horizontal) // Thêm padding cho HStack
                    }
                    .padding(.horizontal, -20)
                }

                if chatService.loadingResponse == false {
                    ZStack(alignment: .trailing) {
                        TextField("", text: $textInput)
                            .placeholder(when: textInput.isEmpty) {
                                Text("Send a message...")
                                    .foregroundStyle(Color.gray.gradient)
                            }
                            .textFieldStyle(.plain)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 14)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(20)
                            .padding(.horizontal)

                        Button {
                            Task {
                                await chatService.sendMessage(message: textInput)
                                showSuggestions = false
                                showSuggestions = false
                                textInput = ""
                            }
                        } label: {
                            Image(systemName: "paperplane.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                                .foregroundStyle(textInput.isEmpty ? Color.gray.gradient : Color.mainColor1.gradient)
                                .padding(.trailing, 25)
                        }
                        .disabled(textInput.isEmpty)
                    }
                    .padding(.bottom, -20)
                    .padding(.horizontal, -20)
                    .opacity(chatService.loadingResponse ? 0 : 1) // Ẩn khi loadingResponse là true
                    .animation(.easeInOut(duration: 0.3), value: chatService.loadingResponse) // Thêm animation
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background {
                colorScheme == .dark ?Color.black.ignoresSafeArea() : Color.white.ignoresSafeArea()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Spacer()
                        Image(.googleGeminiLogo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width, height: 60)
                            .frame(width: UIScreen.main.bounds.width, height: 60)
                            .padding(.leading, 30)
                            .padding(.top, 20)
                            .padding(.top, 20)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isOpenGemini.toggle()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(
                                Color.white,
                                Color.mainColor1.gradient
                            )
                            .font(.system(size: 20))
                            .foregroundStyle(
                                Color.white,
                                Color.mainColor1.gradient
                            )
                    })
                }
            }
        }
    }

    @ViewBuilder func chatMessageView(_ message: ChatMessage) -> some View {
        GeminiChatBubbleView(direction: message.role == .model ? .left : .right) {
            Text(message.message)
                .font(.system(size: 14, weight: .semibold))
                .padding(.all, 20)
                .foregroundStyle(.white)
                .background(message.role == .model ? Color.blue : Color.green)
        }
    }
}

struct GeminiPromptViewPreview: PreviewProvider {
    static var previews: some View {
        GeminiPromptView(isOpenGemini: .constant(true))
    }
}
