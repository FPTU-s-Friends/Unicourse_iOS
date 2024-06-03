//
//  BottomTabButtonUIView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 3/6/24.
//

import SwiftUI

struct BottomTabButtonUIView: View {
    var actionFavorite: () -> Void
    var actionShowComment: () -> Void

    var body: some View {
        HStack {
            Button(action: {}, label: {
                Image(systemName: "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.black)
                    .padding(6)
//                    .background(Color.mainColor3.cornerRadius(20))
            })

            Spacer()

            Button(action: {
                actionShowComment()
            }, label: {
                Image(systemName: "bubble.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.black)
                    .padding(6)
//                    .background(Color.mainColor3.cornerRadius(20))
            })
        }
    }
}

#Preview {
    BottomTabButtonUIView(actionFavorite: {}, actionShowComment: {})
}
