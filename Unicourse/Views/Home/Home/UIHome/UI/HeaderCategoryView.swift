//
//  HeaderCategoryView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct HeaderCategoryView: View {
    var textCategory: String
    var textButton: String
    var action: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(textCategory)
                    .font(.system(size: CGFloat.mainTitlePath, weight: .bold))
                Rectangle()
                    .fill(Color.activeColor)
                    .frame(width: 60, height: 5)
                    .cornerRadius(10)
            }
            Spacer()
            Button(action: {
                action()
            }, label: {
                Text(textButton)
                    .font(.system(size: .mainTitleButtonPath))
                    .foregroundStyle(.white)
                    .padding(6)
                    .padding(.horizontal, 10)
                    .background(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .top, endPoint: .trailing).cornerRadius(10))
            })
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    HeaderCategoryView(textCategory: "Tiến trình", textButton: "Tất cả", action: {})
}
