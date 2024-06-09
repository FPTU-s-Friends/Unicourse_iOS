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
                    Image(systemName: "magnifyingglass.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 34)
                        .padding(3)
                        .foregroundColor(.white)
//                        .background(Color.activeButtonColor.gradient)
                        .clipShape(Circle())
//                        .overlay(
//                            Circle()
//                                .stroke(Color.gray, lineWidth: 0.1)
//                        )
                })

            NavigationLink(destination:
                CommunityView(),

                label: {
                    Image(systemName: "message.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 34)
                        .padding(3)
                        .foregroundColor(.white)
//                        .background(Color.activeButtonColor.gradient)
                        .clipShape(Circle())
//                        .overlay(
//                            Circle()
//                                .stroke(Color.gray, lineWidth: 0.1)
//                        )
                })
            NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 34)
                    .padding(3)
                    .foregroundColor(.white)
//                    .background(Color.activeButtonColor.gradient)
                    .clipShape(Circle())
//                    .overlay(
//                        Circle()
//                            .stroke(Color.gray, lineWidth: 0.1)
//                    )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HeaderButtonView()
}
