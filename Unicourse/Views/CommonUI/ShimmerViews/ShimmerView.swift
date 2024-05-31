//
//  ShimmerView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 31/5/24.
//

import SwiftUI

struct ShimmerView: View {
    @State private var startPoint = UnitPoint(x: -1, y: 0.5)
    @State private var endPoint = UnitPoint(x: 1, y: 0.5)

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1), Color.gray.opacity(0.3)]),
                       startPoint: startPoint, endPoint: endPoint)
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    startPoint = UnitPoint(x: 1, y: 0.5)
                    endPoint = UnitPoint(x: 2, y: 0.5)
                }
            }
    }
}

#Preview {
    ShimmerView()
}
