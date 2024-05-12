//
//  LoadingIndicatorView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 9/5/24.
//

import SwiftUI

struct LoadingIndicatorView: View {
    @State private var isAnimation = false
    @Binding var isLoading: Bool

    private let animationBackgroundColor = Color.mainColor1.opacity(0.3)

    @State private var showCompletionView = false

    var body: some View {
        ZStack {
            if isLoading {
                animationBackgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom), lineWidth: 5)
                        .frame(width: 50, height: 50)
                        .rotationEffect(Angle(degrees: isAnimation ? 360 : 0))
                        .onAppear {
                            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                                self.isAnimation = true
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    LoadingIndicatorView(isLoading: .constant(true))
}
