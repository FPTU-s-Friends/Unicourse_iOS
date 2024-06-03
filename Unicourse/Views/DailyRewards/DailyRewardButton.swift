//
//  DraggableButton.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 3/6/24.
//

import SwiftUI

struct DailyRewardButton: View {
    @State private var dragAmount: CGPoint?

    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack {
                    Spacer()

                    DailyRewardIcon()
                        .frame(width: 50, height: 50)
                        .padding(0)
                        .position(dragAmount ?? CGPoint(x: geometry.size.width - 54, y: geometry.size.height - 400))
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
    DailyRewardButton()
}
