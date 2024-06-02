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
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16))
                .foregroundColor(.black)
                .frame(width: 10, height: 18)
                .padding(.horizontal, 10)
        }
    }
}

#Preview {
    ButtonSearchUIView(isSearchOpen: .constant(true))
}
