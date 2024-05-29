//
//  ButtonGradientUI.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/5/24.
//

import SwiftUI

struct ButtonGradientUI: View {
    let titleButton: String

    var body: some View {
        Text(titleButton)
            .font(.system(size: 16, weight: .medium))
            .frame(maxWidth: .infinity, minHeight: 50)
            .foregroundStyle(.white)
            .background(LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.37, green: 0.87, blue: 0.96), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.62, green: 0.5, blue: 0.97), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0, y: 0.5),
                endPoint: UnitPoint(x: 1, y: 0.5)
            ))
            .cornerRadius(10.0)
            .padding(.horizontal, 5)
            .padding(.top, 10)
            .padding(.bottom, 2)
    }
}
