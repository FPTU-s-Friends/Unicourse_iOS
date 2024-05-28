//
//  PlashScreenView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//
import SwiftUI

struct SlashScreenView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image(.appIcon) // Replace with your app icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color.mainBackgroundColor)
            .overlay {
                WaveShimmerSlashScreen()
            }
        }
    }
}

#Preview {
    SlashScreenView()
}

struct WaveShimmerSlashScreen: View {
    @State private var phase: CGFloat = -1000

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.clear, Color.mainColor1.opacity(0.2), .clear]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .frame(width: 1000, height: 1000)
        .offset(x: phase)
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.phase = 2000
            }
        }
        .mask(
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, Color.mainColor1.opacity(2), .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .scaleEffect(x: 1.5, y: 1, anchor: .center)
        )
    }
}
