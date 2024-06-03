//
//  ButtonBackUIView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import SwiftUI

struct ButtonBackUIView: View {
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "arrow.left")
                .font(.system(size: 16))
                .foregroundColor(.black)
                .frame(width: 10, height: 18)
                .padding(.horizontal, 15)
        })
    }
}

#Preview {
    ButtonBackUIView()
}
