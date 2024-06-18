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
                cartButton
                editButton
                settingButton
            }
        }
    }

    private var cartButton: some View {
        NavigationLink(destination: CartView()) {
            ZStack {
                Image(systemName: "cart.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .symbolRenderingMode(.multicolor)
                    .frame(width: 32)
                    .foregroundStyle(
                        Color.mainColor1.gradient,
                        Color.mainColor3.gradient
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

                if let cart = appData.cart, !cart.items.isEmpty {
                    Text("\(cart.items.count)")
                        .font(.system(size: 10))
                        .foregroundColor(.mainColor3)
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

    private var editButton: some View {
        Button(action: {
            withAnimation {
                isPresentedEditSheet = true
            }
        }) {
            Image(systemName: "square.and.pencil.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .symbolRenderingMode(.multicolor)
                .frame(width: 32)
                .foregroundStyle(
                    Color.mainColor1.gradient,
                    Color.mainColor3.gradient
                )
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }

    private var settingButton: some View {
        Button(action: {
            withAnimation {
                isPresentedSettingSheet = true
            }
        }) {
            Image(systemName: "gearshape.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .symbolRenderingMode(.multicolor)
                .frame(width: 32)
                .foregroundStyle(
                    Color.mainColor1.gradient,
                    Color.mainColor3.gradient
                ) // Màu sắc cho biểu tượng cài đặt
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }
}

#Preview {
    HeaderAccountView(isPresentedEditSheet: .constant(false),
                      isPresentedSettingSheet: .constant(false))
        .environmentObject(AppData())
}
