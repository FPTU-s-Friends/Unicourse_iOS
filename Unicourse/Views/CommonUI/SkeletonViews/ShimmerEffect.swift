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
    @State private var phase: CGFloat = -20

    var body: some View {
        GeometryReader { geometry in
            LinearGradient(
                gradient: Gradient(colors: [.clear, Color.mainColor1.opacity(0.7), .clear]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: geometry.size.width, height: geometry.size.height)
            .offset(x: self.phase)
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    self.phase = geometry.size.width
                }
            }
            .scaleEffect(x: 1.1, y: 1, anchor: .center)
        }
    }
}

#Preview {
    RoundedRectangle(cornerRadius: 10)
        .frame(width: 200, height: 100)
        .foregroundColor(.gray)
        .shimmerWithWave()
}
