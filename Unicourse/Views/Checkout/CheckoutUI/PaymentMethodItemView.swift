//
//  PaymentMethodItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct PaymentMethodItemView: View {
    let isSelected: Bool
    let icon: String
    let name: String

    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)

            Text(name)
                .font(.system(size: 20, weight: .bold))

            Spacer()

            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                .foregroundStyle(Color.activeColor)
        }
        .padding(30)
        .background(Color.white.cornerRadius(20))
    }
}

#Preview {
    PaymentMethodItemView(isSelected: true, icon: "PayPal", name: "PayPal")
}
