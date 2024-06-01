//
//  NavigationQuizButtonComponents.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 1/6/24.
//

import SwiftUI

struct NavigationQuizButtonComponents: View {
    var body: some View {
        HStack(spacing: 20) {
            Button(action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/, label: {
                Text("Câu trước")
            })
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .cornerRadius(8)

            Button(action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/, label: {
                Text("Câu sau")
            })
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .cornerRadius(8)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    NavigationQuizButtonComponents()
}
