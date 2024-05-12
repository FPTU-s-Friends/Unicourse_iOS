//
//  ButtonLoginView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/5/24.
//

import SwiftUI

struct ButtonLoginView: View {
    var action: () -> Void
    var iconImage: String
    var textDetail: String

    var body: some View {
        Button(action: {
            action()
        }, label: {
            VStack {
                HStack {
                    Image(iconImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    Text(textDetail)
                        .font(.system(size: .mainTitlePath, weight: .bold, design: .default))
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: "EDEDED"), lineWidth: 1)
                )
            }
            .padding(.horizontal, 20)
        })
    }
}

#Preview {
    ButtonLoginView(action: {}, iconImage: "googleIcon", textDetail: "Đăng nhập với Google")
}
