//
//  NotificationSettingView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 22/6/24.
//

import SwiftUI

struct NotificationSettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var appNotificationsEnabled: Bool = true
    @State private var courseNotificationsEnabled: Bool = true
    @State private var newsletterNotificationsEnabled: Bool = false
    @State private var chatNotificationsEnabled: Bool = true // Added chat notifications

    var body: some View {
        Form {
            Section(header: Text("Thông báo ứng dụng")) {
                Toggle(isOn: $appNotificationsEnabled) {
                    HStack {
                        Image(systemName: "app.badge.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 22))
                        Text("Nhận thông báo ứng dụng")
                    }
                }
            }

            Section(header: Text("Thông báo khóa học")) {
                Toggle(isOn: $courseNotificationsEnabled) {
                    HStack {
                        Image(systemName: "book.circle.fill")
                            .foregroundColor(.green) // Changed color to green for course updates
                            .font(.system(size: 22))
                        Text("Cập nhật khóa học")
                    }
                }
                Toggle(isOn: $newsletterNotificationsEnabled) {
                    HStack {
                        Image(systemName: "newspaper.circle.fill")
                            .foregroundColor(.orange) // Changed color to orange for newsletter
                            .font(.system(size: 22))
                        Text("Bản tin")
                    }
                }
            }

            Section(header: Text("Thông báo trò chuyện")) {
                Toggle(isOn: $chatNotificationsEnabled) {
                    HStack {
                        Image(systemName: "message.circle.fill")
                            .foregroundColor(.purple) // Changed color to purple for chat notifications
                            .font(.system(size: 22))
                        Text("Tin nhắn trò chuyện")
                    }
                }
            }
        }
        .navigationTitle("Cài đặt thông báo")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonCircleUIView(systemName: "arrow.left.circle.fill") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct NotificationSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSettingView()
    }
}
