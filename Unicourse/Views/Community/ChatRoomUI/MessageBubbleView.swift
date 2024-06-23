//
//  MessageBubbleView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/6/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct MessageBubbleView: View {
    @EnvironmentObject var appData: AppData
    var message: MessageChatRoomDetailModel

    var body: some View {
        HStack {
            if message.user._id == appData.userInfo?._id {
                Spacer()
                VStack(alignment: .leading) {
                    Text(message.user.fullName)
                        .font(.caption2)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 10)

                    Text(message.message)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, alignment: .trailing)
                }

                WebImage(url: URL(string: message.user.profile_image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .cornerRadius(20)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.gray.opacity(0.2))
                        .shimmerWithWave()
                }
            } else {
                WebImage(url: URL(string: message.user.profile_image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .cornerRadius(20)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.gray.opacity(0.2))
                        .shimmerWithWave()
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(message.user.fullName)
                        .font(.caption2)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.gray)
                        .padding(.leading, 10)

                    Text(message.message)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .foregroundColor(.black)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                }
                .offset(y: -5)

                Spacer()
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    MessageBubbleView(message: .sampleData)
        .environmentObject(AppData())
}
