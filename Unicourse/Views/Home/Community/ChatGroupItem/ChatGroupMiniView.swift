//
//  ChatGroupMiniView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 18/5/24.
//

import SwiftUI

struct ChatGroupMiniView: View {
    var body: some View {
        HStack {
            ZStack {
                Image("User")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)

                Circle()
                    .frame(width: 20)
                    .foregroundStyle(.green)
                    .offset(x: 20, y: 20)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Phòng chat Kỳ 1")
                    .font(.system(size: 16, weight: .semibold))

                Text("Xin chào, tôi đã nhận được email về khoản phí mà tôi không xác định được. Bạn có thể giúp tôi điều tra bộ lông này không")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
            }

            VStack(alignment: .trailing) {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14)
                    .foregroundStyle(Color.mainColor1)
            }
            .padding(.horizontal, 10)
        }
        .padding(.horizontal, 10)
        .padding(.top, 16)
    }
}

#Preview {
    ChatGroupMiniView()
}
