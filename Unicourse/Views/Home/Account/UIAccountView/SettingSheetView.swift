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
                Section(header: Text(NSLocalizedString("account_settings", comment: ""))) {
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
                            Text(NSLocalizedString("account_settings", comment: ""))
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
                            Text(NSLocalizedString("notifications", comment: ""))
                        }
                    }
                }

                Section(header: Text(NSLocalizedString("privacy", comment: ""))) {
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
                            Text(NSLocalizedString("privacy", comment: ""))
                        }
                    }
                }

                Section(header: Text(NSLocalizedString("help_support", comment: ""))) {
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
                            Text(NSLocalizedString("help_support", comment: ""))
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
                            Text(NSLocalizedString("website", comment: ""))
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
                            Text(NSLocalizedString("about_us", comment: ""))
                        }
                    }

                    Button(action: {
                        OpenURLUtility.openURL("https://www.facebook.com/profile.php?id=61559287804624")
                    }) {
                        HStack {
                            Image(systemName: "shared.with.you.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.cyan)
                            Text(NSLocalizedString("visit_us", comment: ""))
                                .foregroundColor(.primary)
                        }
                    }
                }

                Section {
                    Button(action: {
                        print("Đóng tài khoản được nhấn")
                    }) {
                        HStack {
                            Image(systemName: "archivebox.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.closeAccountIconColor)
                            Text(NSLocalizedString("close_account", comment: ""))
                        }
                        .foregroundColor(.closeAccountIconColor)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(NSLocalizedString("settings", comment: ""))
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
