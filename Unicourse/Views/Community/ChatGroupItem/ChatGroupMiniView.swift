//
//  ChatGroupMiniView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 18/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct ChatGroupMiniView: View {
    var chatRoom: ChatRoomModel

    var body: some View {
        HStack {
            ZStack {
                WebImage(url: URL(string: chatRoom.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                        )
                        .clipped()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 60, height: 60)
                        .shimmerWithWave()
                }

                Circle()
                    .frame(width: 16)
                    .foregroundStyle(.green)
                    .offset(x: 16, y: 20)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(chatRoom.name)
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .foregroundStyle(Color.black)

                Text(chatRoom.messages.last?.message ?? "")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
            }

            Spacer()
        }
        .padding(.vertical, 5)
        .background {
            Color.mainBackgroundColor
                .cornerRadius(20)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ChatGroupMiniView(chatRoom: .sampleData)
}
