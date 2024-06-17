//
//  HeaderButtonView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct HeaderButtonView: View {
    var body: some View {
        HStack {
            NavigationLink(destination: SearchEntryView()) {
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32)
                    .foregroundStyle(
                        Color.mainColor3.gradient,
                        Color.mainColor1.gradient
                    )
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 0.1)
                    )
            }
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

            NavigationLink(destination: CommunityView()) {
                Image(systemName: "message.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32)
                    .foregroundStyle(
                        Color.mainColor3.gradient,
                        Color.mainColor1.gradient
                    )
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 0.1)
                    )
            }
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

            NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32)
                    .foregroundStyle(
                        Color.mainColor3.gradient,
                        Color.mainColor1.gradient
                    )
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 0.1)
                    )
            }
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HeaderButtonView()
}
