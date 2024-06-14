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
    @State private var isLogoAnimating = false
    @State var timer: Timer?
//    @State private var isBreathing = false

    var body: some View {
        //                Image("geminiIcon")
        //                    .resizable()
        //                    .aspectRatio(contentMode: .fit)
        //                    .frame(width: 60, height: 60)
        //                    .scaleEffect(isBreathing ? 1.4 : 1.0)
        //                    .animation(Animation.easeInOut(duration: 1.4).repeatForever(autoreverses: true), value: isBreathing)
        //                    .onAppear {
        //                        isBreathing = true
        //                    }
        //                    .padding()
        NavigationView {
            VStack {
                Image(.googleGeminiLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.5)
                    .padding(.horizontal, 10)
                    .scaleEffect(isLogoAnimating ? 0.5 : 1)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isLogoAnimating)

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
                    .onChange(of: chatService.loadingResponse) { _, newValue in
                        if newValue {
                            startLoadingAnimation()
                        } else {
                            stopLoadingAnimation()
                        }
                    }
                }

                HStack {
                    TextField("Enter a message...", text: $textInput)
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.black)
                    Button {
                        Task {
                            await chatService.sendMessage(message: textInput)
                            textInput = ""
                        }

                    } label: {
                        Image(systemName: "paperplane.fill")
                    }
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background {
                Color.black
                    .ignoresSafeArea()
            }
        }
    }

    @ViewBuilder func chatMessageView(_ message: ChatMessage) -> some View {
        ChatBubble(direction: message.role == .model ? .left : .right) {
            Text(message.message)
                .font(.system(size: 14, weight: .semibold))
                .padding(.all, 20)
                .foregroundStyle(.white)
                .background(message.role == .model ? Color.blue : Color.green)
        }
    }

    func startLoadingAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            isLogoAnimating.toggle()
        }
    }

    func stopLoadingAnimation() {
        isLogoAnimating = false
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    GeminiPromptView()
}

struct ChatBubble<Content: View>: View {
    let direction: ChatBubbleDirection
    let content: Content

    init(direction: ChatBubbleDirection, @ViewBuilder content: () -> Content) {
        self.direction = direction
        self.content = content()
    }

    var body: some View {
        HStack {
            if direction == .right { Spacer() }
            content
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .overlay(
                    ChatBubbleArrow(direction: direction)
                        .fill(direction == .left ? Color.blue : Color.green)
                        .frame(width: 24, height: 24),
                    alignment: direction == .left ? .bottomLeading : .bottomTrailing
                )
                .padding(direction == .left ? .trailing : .leading, 10) // Add space on the opposite side
            if direction == .left { Spacer() }
        }
    }
}

struct ChatBubbleArrow: Shape {
    let direction: ChatBubbleDirection

    func path(in rect: CGRect) -> Path {
        var path = Path()

        if direction == .left {
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        } else {
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }

        path.closeSubpath()
        return path
    }
}

enum ChatBubbleDirection {
    case left
    case right
}
