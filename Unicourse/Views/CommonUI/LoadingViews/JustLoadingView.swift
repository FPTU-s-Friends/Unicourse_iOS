//
//  JustLoadingView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 31/5/24.
//

import SwiftUI

struct JustLoadingView: View {
    // comment
    @State private var isAnimation = false
    @Binding var isLoading: Bool
    private let animationBackgroundColor = Color.mainColor1.opacity(0.3)
    @State private var showCompletionView = false

    var body: some View {
        ZStack {
            if isLoading {
                VStack {
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom), lineWidth: 4)
                        .frame(width: 20, height: 20)
                        .rotationEffect(Angle(degrees: isAnimation ? 360 : 0))
                        .onAppear {
                            withAnimation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false)) {
                                isAnimation = true
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    JustLoadingView(isLoading: .constant(true))
}
