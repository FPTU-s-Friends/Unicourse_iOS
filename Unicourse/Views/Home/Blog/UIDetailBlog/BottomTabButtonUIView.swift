//
//  BottomTabButtonUIView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 3/6/24.
//

import SwiftUI

struct BottomTabButtonUIView: View {
    var isLikeBlog: Bool
    var actionFavorite: () -> Void
    var actionShowComment: () -> Void

    var body: some View {
        HStack {
            Button(action: {
                actionFavorite()
            }, label: {
                Image(systemName: isLikeBlog ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24)
                    .foregroundStyle(Color.red.gradient)
                    .padding(6)
            })

            Spacer()

            Button(action: {
                actionShowComment()
            }, label: {
                Image(systemName: "bubble.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24)
                    .foregroundStyle(Color.mainColor1.gradient)
            })
        }
    }
}

#Preview {
    BottomTabButtonUIView(isLikeBlog: true, actionFavorite: {}, actionShowComment: {})
}
