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
            NavigationLink(destination:
                SearchEntryView(),

                label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.activeButtonColor.gradient)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 0.1)
                        )
                })

            NavigationLink(destination:
                CommunityView(),

                label: {
                    Image(systemName: "message")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.activeButtonColor.gradient)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 0.1)
                        )
                })
            NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.activeButtonColor.gradient)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 0.1)
                    )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HeaderButtonView()
}
