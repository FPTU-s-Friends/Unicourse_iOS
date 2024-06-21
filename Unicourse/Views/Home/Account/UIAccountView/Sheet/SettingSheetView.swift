//
//  SettingSheetView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 9/6/24.
//

import SwiftUI

struct SettingSheetView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Tài Khoản ")) {
                    NavigationLink {
                        AccountSettingsView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
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
                    NavigationLink {
                        NotificationSettingView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
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
                    NavigationLink {
                        PrivacyView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
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

                Section(header: Text("Visit Us")) {
                    NavigationLink {
                        WebViewUI(url: "https://unicourse.vn")
                    } label: {
                        HStack {
                            Image(systemName: "globe.central.south.asia.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundColor(.blue)
                            Text("Website")
                        }
                    }
                }

                Section(header: Text("Hỗ Trợ")) {
                    NavigationLink {
                        HelpAndSupportView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundColor(.helpIconColor)
                            Text("Help & Support")
                        }
                    }

                    NavigationLink {
                        AboutUsView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
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
            .listStyle(InsetGroupedListStyle()) // Use a different list style for a better appearance
            .navigationTitle("Cài đặt ⚙️")
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
}

#Preview {
    SettingSheetView()
}

import SwiftUI
