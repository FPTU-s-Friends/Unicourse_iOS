//
//  ButtonCircleUIView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

import SwiftUI

struct ButtonCircleUIView: View {
    var systemName: String
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 34)
                .foregroundStyle(
                    Color.white,
                    Color.mainColor1.gradient
                )
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray, lineWidth: 0.1)
                )
                .padding(3)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        })
    }
}

#Preview {
    ButtonCircleUIView(systemName: "book.circle.fill") {}
}
