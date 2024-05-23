//
//  ShimmerEffect.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

extension View {
    func shimmerWithWave() -> some View {
        self.overlay(
            WaveShimmer()
                .mask(self)
        )
    }
}

struct WaveShimmer: View {
    @State private var phase: CGFloat = 0

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.clear, Color.gray.opacity(0.3), .clear]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .frame(width: 300, height: 300)
        .offset(x: self.phase)
        .onAppear {
            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                self.phase = 400
            }
        }
        .mask(
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, Color.gray.opacity(0.3), .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .rotationEffect(.degrees(30))
                .scaleEffect(x: 1.5, y: 1, anchor: .center)
        )
    }
}

#Preview {
    WaveShimmer()
}
