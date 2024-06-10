//
//  HeaderAccountView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct HeaderAccountView: View {
    @EnvironmentObject var appData: AppData
    @Binding var isPresentedEditSheet: Bool
    @Binding var isPresentedSettingSheet: Bool

    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    VStack {
                        NavigationLink(destination: CartView()) {
                            ZStack {
                                Image(systemName: "cart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .background(Color.UIButtonGreen)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.gray, lineWidth: 0.1)
                                    )
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

                                if let cart = appData.cart, !cart.items.isEmpty {
                                    Text("\(cart.items.count)")
                                        .font(.system(size: 10))
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 3)
                                        .background(Color.red.cornerRadius(20))
                                        .padding(.leading, 20)
                                        .padding(.bottom, 20)
                                        .lineLimit(1)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                    }
                    Button(action: {
                        withAnimation {
                            isPresentedEditSheet = true
                        }
                    }, label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.UIButtonGreen)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 0.1)
                            )
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    })

                    Button(action: {
                        withAnimation {
                            isPresentedSettingSheet = true
                        }
                    }, label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.UIButtonGreen)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 0.1)
                            )
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    })
                }
            }
        }
    }
}

#Preview {
    HeaderAccountView(isPresentedEditSheet: .constant(false),
                      isPresentedSettingSheet: .constant(false))
        .environmentObject(AppData())
}
