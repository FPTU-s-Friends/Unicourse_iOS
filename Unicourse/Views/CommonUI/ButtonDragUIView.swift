//
//  DraggableButton.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 3/6/24.
//

import SwiftUI

struct ButtonDragUIView: View {
    @State private var dragAmount: CGPoint?
    @State private var isAnimating = false

    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack {
                    Spacer()

                    Image(.aiIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .position(dragAmount ?? CGPoint(x: geometry.size.width - 50, y: geometry.size.height - 100))
                        .scaleEffect(isAnimating ? 1.02 : 1.0)
                        .opacity(isAnimating ? 1.0 : 0.8)
                        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
                        .onAppear { isAnimating = true }
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    withAnimation(.linear) {
                                        dragAmount = value.location
                                    }
                                }
                                .onEnded { value in
                                    var currentPosition = value.location

                                    let minX: CGFloat = 34
                                    let maxX: CGFloat = geometry.size.width - 45
                                    let minY: CGFloat = 50
                                    let maxY: CGFloat = geometry.size.height - 50

                                    if currentPosition.x > (geometry.size.width / 2) {
                                        currentPosition.x = maxX
                                    } else {
                                        currentPosition.x = minX
                                    }

                                    currentPosition.y = min(max(currentPosition.y, minY), maxY)

                                    withAnimation(.spring()) {
                                        dragAmount = currentPosition
                                    }
                                }
                        )
                }
            }
        }
        .padding(0)
    }
}

#Preview {
    ButtonDragUIView()
}
