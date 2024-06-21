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
            Section(header: Text("App Notifications")) {
                Toggle(isOn: $appNotificationsEnabled) {
                    HStack {
                        Image(systemName: "app.badge.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 22))
                        Text("Receive App Notifications")
                    }
                }
            }

            Section(header: Text("Course Notifications")) {
                Toggle(isOn: $courseNotificationsEnabled) {
                    HStack {
                        Image(systemName: "book.circle.fill")
                            .foregroundColor(.green) // Changed color to green for course updates
                            .font(.system(size: 22))
                        Text("Course Updates")
                    }
                }
                Toggle(isOn: $newsletterNotificationsEnabled) {
                    HStack {
                        Image(systemName: "newspaper.circle.fill")
                            .foregroundColor(.orange) // Changed color to orange for newsletter
                            .font(.system(size: 22))
                        Text("Newsletter")
                    }
                }
            }

            Section(header: Text("Chat Notifications")) {
                Toggle(isOn: $chatNotificationsEnabled) {
                    HStack {
                        Image(systemName: "message.circle.fill")
                            .foregroundColor(.green) // Changed color to purple for chat notifications
                            .font(.system(size: 22))
                        Text("Chat Messages")
                    }
                }
            }
        }
        .navigationTitle("Notification Settings")
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
