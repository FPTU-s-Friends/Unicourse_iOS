//
//  SettingSheetView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 9/6/24.
//

import SwiftUI

struct SettingSheetView: View {
    var body: some View {
        List {
            Section(header: Text("Tài Khoản")) {
                Button(action: {
                    print("Account Settings tapped")
                }) {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .foregroundColor(.accountIconColor)
                        Text("Account Settings")
                    }
                }
            }

            Section(header: Text("Thông Báo")) {
                Button(action: {
                    print("Notifications tapped")
                }) {
                    HStack {
                        Image(systemName: "bell.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .foregroundColor(.notificationIconColor)
                        Text("Notifications")
                    }
                }
            }

            Section(header: Text("Điều Khoản")) {
                Button(action: {
                    print("Privacy tapped")
                }) {
                    HStack {
                        Image(systemName: "lock.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .foregroundColor(.privacyIconColor)
                        Text("Privacy")
                    }
                }
            }

            Section(header: Text("Hỗ Trợ")) {
                Button(action: {
                    print("Help & Support tapped")
                }) {
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .foregroundColor(.helpIconColor)
                        Text("Help & Support")
                    }
                }

                Button(action: {
                    print("About Us tapped")
                }) {
                    HStack {
                        Image(systemName: "info.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .foregroundColor(.aboutIconColor)
                        Text("About Us")
                    }
                }
            }

            Section {
                Button(action: {
                    print("Close Account tapped")
                }) {
                    HStack {
                        Image(systemName: "archivebox.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .foregroundColor(.closeAccountIconColor)
                        Text("Close Account")
                    }
                    .foregroundColor(.closeAccountIconColor)
                }
            }
        }
        .listStyle(.sidebar)
        .background {
            Color.mainBackgroundColor
                .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    SettingSheetView()
}
