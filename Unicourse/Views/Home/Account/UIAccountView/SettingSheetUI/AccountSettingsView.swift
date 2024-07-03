//
//  AccountSettingsView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 22/6/24.
//

import SwiftUI

struct AccountSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var notificationsEnabled: Bool = true
    @State private var newsletterSubscribed: Bool = false
    @State private var showAlert: Bool = false
    @State private var isLoggedOut = false

    var body: some View {
        NavigationView {
            Form {
                // Profile Section
                Section(header: Text("Hồ sơ")) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 22))
                        Text("Tên người dùng")
                        Spacer()
                        TextField("Tên người dùng", text: $username)
                            .multilineTextAlignment(.trailing)
                            .disabled(true)
                            .foregroundStyle(.gray)
                    }
                    HStack {
                        Image(systemName: "envelope.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 22))
                        Text("Email")
                        Spacer()
                        TextField("Email", text: $email)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disabled(true)
                            .foregroundStyle(.gray)
                    }
                }

                // Notifications Section
                Section(header: Text("Thông báo")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Bật thông báo")
                    }
                    Toggle(isOn: $newsletterSubscribed) {
                        Text("Đăng ký nhận tin")
                    }
                }

                // Support Section
                Section(header: Text("Hỗ trợ")) {
                    NavigationLink(destination: {
                        HelpAndSupportView()
                            .navigationBarBackButtonHidden(true)
                    }) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 22))
                            Text("Trợ giúp & Hỗ trợ")
                        }
                    }
                }

                // Account Actions Section
                Section {
                    Button(action: {
                        showAlert = true
                    }) {
                        HStack {
                            Image(systemName: "arrowshape.turn.up.left.circle.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 22))
                            Text("Đăng xuất")
                                .foregroundColor(.red)
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Đăng xuất"),
                            message: Text("Bạn có chắc chắn muốn đăng xuất không?"),
                            primaryButton: .destructive(Text("Đăng xuất")) {
                                withAnimation(.spring) {
                                    appData.isLoading = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        Task {
                                            do {
                                                try appData.signOutUser()
                                                isLoggedOut = true // Set isLoggedOut to true after sign out
                                                appData.mainTabSelection = 0
                                            } catch {
                                                appData.error = "Lỗi khi đăng xuất"
                                                appData.isShowingAlert = true
                                            }
                                            appData.isLoading = false
                                        }
                                    }
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .onAppear {
                username = appData.userInfo?.fullName ?? ""
                email = appData.userInfo?.email ?? ""
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ButtonCircleUIView(systemName: "arrow.left.circle.fill") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationDestination(isPresented: $isLoggedOut) {
                LoginView()
            }
            .navigationTitle("Cài đặt tài khoản")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    AccountSettingsView()
        .environmentObject(AppData())
}
