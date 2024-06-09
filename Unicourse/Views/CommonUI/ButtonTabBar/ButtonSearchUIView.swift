//
//  ButtonSearchUIView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import SwiftUI

struct ButtonSearchUIView: View {
    @Binding var isSearchOpen: Bool

    var body: some View {
        Button(action: {
            withAnimation {
                isSearchOpen.toggle()
            }
        }) {
            Image(systemName: "magnifyingglass.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 34)
                .foregroundColor(.mainColor1)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray, lineWidth: 0.1)
                )
        }
    }
}

#Preview {
    ButtonSearchUIView(isSearchOpen: .constant(true))
}
