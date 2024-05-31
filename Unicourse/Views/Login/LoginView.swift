//
//  LoginView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/5/24.
//

import FirebaseCore
import GoogleSignInSwift
import JWTDecode
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @EnvironmentObject var appData: AppData
    @State private var showMainHomeView = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                LinearGradient(gradient: Gradient(colors: [Color.mainColor1, Color.mainColor2]), startPoint: .topLeading, endPoint: .bottomTrailing)

                VStack {
                    Image("appIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .padding()
                        .padding(.top, 20)
                    Text("UniCourse")
                        .font(.system(size: 36, weight: .semibold, design: .default))
                    Text("Học theo cách của riêng bạn với các bài học tương tác và giao diện trực quan.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 12))
                        .padding(.horizontal, 60)
                        .padding(.top, 2)
                        .foregroundColor(.gray)

                    Spacer()

                    ButtonLoginView(action: {
                        Task {
                            await handleSignIn()
                        }
                    }, iconImage: "googleIcon", textDetail: "Đăng nhập với Google")
                        .padding(.bottom, 10)

                    ButtonLoginView(action: {
                        Task {
                            await handleSignInGit()
                        }
                    }, iconImage: "githubIcon", textDetail: "Đăng nhập với Github")

                    Spacer()

                    DeviderCustomView(text: "Hoặc")

                    Spacer()

                    Button(action: {}) {
                        Text("Đăng nhập với số điện thoại")
                            .fontWeight(.bold)
                            .frame(width: 300, height: 60)
                            .foregroundColor(.white)
                    }
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.mainColor1, Color.mainColor2]), startPoint: .leading, endPoint: .bottom)
                    )
                    .cornerRadius(30)

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.80)
                .background(Color(hex: "F7F8FC"))
                .cornerRadius(50)

                LoadingIndicatorView(isLoading: $appData.isLoading)
                    .opacity(1)
                    .animation(.easeInOut(duration: 0.5), value: appData.isLoading)
            }
            .ignoresSafeArea(.all)
            .navigationDestination(isPresented: Binding<Bool>(
                get: { appData.user != nil },
                set: { _ in
                    // Không làm gì khi giá trị set thay đổi
                }
            ), destination: {
                CustomHomeView()
                    .navigationBarBackButtonHidden(true)
            })
        }
    }

    // Function to handle sign in
    private func handleSignIn() async {
        appData.isLoading = true
        Task {
            do {
                let token = try await viewModel.signInGoogle()
                let jwtToken = String(token.split(separator: " ")[1])
                appData.token = jwtToken
                appData.decodeJWTTokenAndSetUserProfile(token: jwtToken)
            } catch {
                appData.error = error.localizedDescription
                appData.isShowingAlert = true
                print("Error during sign-in:", error)
            }
        }

        appData.isLoading = false
    }

    private func handleSignInGit() async {
        appData.isLoading = true
        Task {
            do {
                let token = try await viewModel.signInGithub()
                print(token)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AppData())
}
