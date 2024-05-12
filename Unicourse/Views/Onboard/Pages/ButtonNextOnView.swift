//
//  ButtonNextOnView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/5/24.
//

import SwiftUI

struct ButtonNextOnView: View {
    var action: () -> Void
    var text: String
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(text)
                .fontWeight(.bold)
                .frame(width: 300, height: 60)
                .foregroundColor(.white)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.mainColor1, Color.mainColor2]), startPoint: .leading, endPoint: .bottom)
        )
        .cornerRadius(10)
    }
    

}

#Preview {
    ButtonNextOnView(action: {}, text: "Next")
}
