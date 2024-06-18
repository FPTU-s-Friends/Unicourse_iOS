//
//  HeaderCartItemview.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct HeaderCartItemView: View {
    @EnvironmentObject var appData: AppData
    @Binding var isShowMore: Bool

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

            Button(action: {
                withAnimation {
                    isShowMore.toggle()
                }
            }, label: {
                Text(isShowMore ? "Thu gọn" : "Xem thêm")
                    .font(.system(size: .mainTitleButtonPath))
                    .foregroundStyle(.white)
                    .padding(6)
                    .padding(.horizontal, 10)
                    .background(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(20)
            })
        }
    }
}

#Preview {
    HeaderCartItemView(isShowMore: .constant(false))
}
