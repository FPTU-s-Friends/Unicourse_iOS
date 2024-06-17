//
//  AIMessageBubbleView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 14/6/24.
//

import SwiftUI

struct GeminiChatBubbleView<Content: View>: View {
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

#Preview {
    GeminiChatBubbleView(direction: .right, content: { Text("") })
}
