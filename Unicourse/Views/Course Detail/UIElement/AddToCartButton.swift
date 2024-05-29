//
//  AddToCartButton.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 29/5/24.
//

import SwiftUI

struct AddToCartButton: View {
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "cart")
                .font(.system(size: 25))
                .frame(width: 50, height: 50)
                .foregroundStyle(.black)
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
                .cornerRadius(10)
                .padding(.horizontal, 5)
                .padding(.top, 10)
                .padding(.bottom, 2)
        }
    }
}

#Preview {
    AddToCartButton(action: { print("1") })
}
