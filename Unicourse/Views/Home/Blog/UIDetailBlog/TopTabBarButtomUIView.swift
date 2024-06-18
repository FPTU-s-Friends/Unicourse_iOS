//
//  TopTabBarButtomUIView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 3/6/24.
//

import SwiftUI

struct TopTabBarButtomUIView: View {
    var body: some View {
        HStack(spacing: 10) {
            Button(action: {}, label: {
                Image(systemName: "bookmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 34)
                    .foregroundStyle(
                        Color.white,
                        Color.mainColor1.gradient
                    )
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 0.1)
                    )
                    .padding(3)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            })

            Button(action: {}, label: {
                Image(systemName: "globe.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 34)
                    .foregroundStyle(
                        Color.white,
                        Color.mainColor1.gradient
                    )
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 0.1)
                    )
                    .padding(3)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            })

            Button(action: {}, label: {
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 34)
                    .foregroundStyle(
                        Color.white,
                        Color.mainColor1.gradient
                    )
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 0.1)
                    )
                    .padding(3)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            })
        }
    }
}

#Preview {
    TopTabBarButtomUIView()
}
