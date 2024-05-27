//  TabShapeView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import SwiftUI

struct TabShape: Shape {
    var midPoint: CGFloat

    func path(in rect: CGRect) -> Path {
        return Path { path in
            // Draw the rectangle shape first
            path.addPath(Rectangle().path(in: rect))

            // Now draw the upward curve
            path.move(to: CGPoint(x: midPoint - 60, y: 0))

            let to = CGPoint(x: midPoint, y: -14)
            let control1 = CGPoint(x: midPoint - 20, y: 0)
            let control2 = CGPoint(x: midPoint - 20, y: -14)

            path.addCurve(to: to, control1: control1, control2: control2)

            let to1 = CGPoint(x: midPoint + 60, y: 0)
            let control3 = CGPoint(x: midPoint + 20, y: -14) // Adjusted for smoother curve
            let control4 = CGPoint(x: midPoint + 20, y: 0) // Adjusted for smoother curve

            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}

#Preview {
    TabShape(midPoint: 150)
        .frame(width: 300, height: 80)
        .background(Color.gray)
}
