//
//  HeaderCartItemview.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct HeaderCartItemView: View {
    @EnvironmentObject var appData: AppData
    @Binding var isCheckedAllItemPerson: Bool

    var body: some View {
        HStack {
            Image("User")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)

            Text(appData.userInfo?.fullName ?? "")
                .font(.system(size: 12, weight: .light))
                .foregroundStyle(.gray)

            Spacer()

            Button(action: {}, label: {
                Image(systemName: "pencil.line")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14)
                    .foregroundStyle(Color.accentColor)
                    .padding(8)
                    .background(Color.grayItem.cornerRadius(10))
            })
        }
    }
}

#Preview {
    HeaderCartItemView(isCheckedAllItemPerson: .constant(false))
}
