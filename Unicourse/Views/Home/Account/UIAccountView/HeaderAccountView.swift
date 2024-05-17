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
                        NavigationLink(destination: CartView()) {
                            ZStack {
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
                                Text("12")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.white)
                                    .padding(2)
                                    .background(Color.red.cornerRadius(20))
                                    .padding(.leading, 20)
                                    .padding(.bottom, 20)
                            }
                        }
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

                    Button(action: {}, label: {
                        Image(systemName: "gearshape")
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
        }
        .offset(y: -10)
    }
}

#Preview {
    HeaderAccountView()
}
