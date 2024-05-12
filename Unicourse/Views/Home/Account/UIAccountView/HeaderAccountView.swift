//
//  HeaderAccountView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct HeaderAccountView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    VStack {
                        Button(action: {}, label: {
                            Image(systemName: "cart")
                                .font(.system(size: 20))
                                .padding(10)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 0.1)
                                )
                        })
                    }
                    Button(action: {}, label: {
                        Image(systemName: "pencil")
                            .font(.system(size: 20))
                            .padding(10)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 0.1)
                            )
                    })
                }
            }
            .padding(.horizontal, 20)

            Text("12")
                .font(.system(size: 10))
                .foregroundStyle(.white)
                .padding(2)
                .background(Color.red.cornerRadius(20))
                .offset(x: 130, y: -50)
        }
        .offset(y: 20)
    }
}

#Preview {
    HeaderAccountView()
}
