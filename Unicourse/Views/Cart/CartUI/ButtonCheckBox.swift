//
//  ButtonCheckBox.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct ButtonCheckBox: View {
    @Binding var isChecked: Bool
    var body: some View {
        Button(action: {
            withAnimation {
                isChecked.toggle()
            }
        }, label: {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(isChecked ? .mainColor1 : .gray)
                .frame(width: 16)
                .padding(.trailing, 10)

        })
    }
}

#Preview {
    ButtonCheckBox(isChecked: .constant(true))
}
