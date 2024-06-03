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
                Image(systemName: "bookmark")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .frame(width: 10, height: 18)
                    .padding(.horizontal, 10)
            })

            Button(action: {}, label: {
                Image(systemName: "globe")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .frame(width: 10, height: 18)
                    .padding(.horizontal, 10)
            })

            Button(action: {}, label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .frame(width: 10, height: 18)
                    .padding(.horizontal, 10)
            })
        }
    }
}

#Preview {
    TopTabBarButtomUIView()
}
