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
                        .frame(width: 120)
                        .padding()
                        .padding(.top, 20)
                    Text("UniCourse")
                        .font(.system(size: 30, weight: .semibold, design: .default))
                    Text("Học theo cách của riêng bạn với các bài học tương tác và giao diện trực quan.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 12))
                        .padding(.horizontal, 60)
                        .padding(.top, 2)
                        .foregroundColor(.gray)

                    Spacer()

                    GoogleLoginButtonView(viewModel: viewModel)

                    GithubLoginButtonView(viewModel: viewModel)

                    AppleLoginButtonView(viewModel: viewModel)

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
                    .animation(.spring, value: appData.isLoading)
            }
            .ignoresSafeArea(.all)
            .navigationDestination(isPresented: Binding<Bool>(
                get: { appData.userInfo != nil },
                set: { _ in
                    // Không làm gì khi giá trị set thay đổi
                }
            ), destination: {
                CustomHomeView()
                    .navigationBarBackButtonHidden(true)
            })
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AppData())
}
