//
//  GoogleLoginButtonView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 31/5/24.
//

import SwiftUI

struct GoogleLoginButtonView: View {
    @ObservedObject var viewModel: LoginViewModel
    @EnvironmentObject var appData: AppData

    var body: some View {
        VStack {
            ButtonLoginView(action: {
                Task {
                    try await handleSignIn()
                }
            }, iconImage: "googleIcon", textDetail: "Đăng nhập với Google")
        }
        .padding(.bottom, 10)
    }

    // Function to handle sign in
    private func handleSignIn() async throws {
        Task {
            do {
                appData.isLoading = true
                let token = try await viewModel.signInGoogle()
                let jwtToken = String(token.split(separator: " ")[1])
                appData.token = jwtToken
                try await appData.decodeJWTTokenAndSetUserProfile(token: jwtToken)
            } catch {
                appData.error = error.localizedDescription
                appData.isShowingAlert = true
                print("Error during Google sign-in:", error)
            }
            appData.isLoading = false
        }
    }
}

#Preview {
    GoogleLoginButtonView(viewModel: LoginViewModel())
}
