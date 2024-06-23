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
                Section(header: Text("Tài Khoản")) {
                    NavigationLink {
                        AccountSettingsView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.accountIconColor)
                            Text("Account Settings")
                        }
                    }

                    NavigationLink {
                        NotificationSettingView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Image(systemName: "bell.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
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
                                .frame(width: 20, height: 20)
                                .foregroundColor(.privacyIconColor)
                            Text("Privacy")
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
                                .frame(width: 20, height: 20)
                                .foregroundColor(.helpIconColor)
                            Text("Help & Support")
                        }
                    }

                    NavigationLink {
                        WebViewUI(url: "https://unicourse.vn")
                    } label: {
                        HStack {
                            Image(systemName: "globe.central.south.asia.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                            Text("Website")
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
                                .frame(width: 20, height: 20)
                                .foregroundColor(.aboutIconColor)
                            Text("About Us")
                        }
                    }

                    // Nút mở trong WebView hoặc ứng dụng Facebook
                    Button(action: {
                        OpenURLUtility.openURL("https://www.facebook.com/profile.php?id=61559287804624")
                    }) {
                        HStack {
                            Image(systemName: "shared.with.you.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.cyan)
                            Text("Visit Us")
                                .foregroundColor(.primary)
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
                                .frame(width: 20, height: 20)
                                .foregroundColor(.closeAccountIconColor)
                            Text("Close Account")
                        }
                        .foregroundColor(.closeAccountIconColor)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
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
