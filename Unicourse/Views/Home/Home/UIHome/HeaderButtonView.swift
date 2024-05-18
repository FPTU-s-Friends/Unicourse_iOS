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
                SearchEntryView()
                    .navigationBarBackButtonHidden(true),

                label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.activeButtonColor)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 0.1)
                        )
                })

            NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell")
                    .font(.system(size: 20))
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.activeButtonColor)
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
