//
//  GithubLoginButtonView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 31/5/24.
//

import SwiftUI

struct GithubLoginButtonView: View {
    @ObservedObject var viewModel: LoginViewModel
    @EnvironmentObject var appData: AppData

    var body: some View {
        VStack {
            ButtonLoginView(action: {
                Task {
                    try await handleSignInGit()
                }

            }, iconImage: "githubIcon", textDetail: "Đăng nhập với Github")
        }
        .padding(.bottom, 10)
    }

    private func handleSignInGit() async throws {
        withAnimation(.spring) {
            appData.isLoading = true
            Task {
                do {
                    let token = try await viewModel.signInGithub()
                    let jwtToken = String(token.split(separator: " ")[1])
                    appData.token = jwtToken
                    try await appData.decodeJWTTokenAndSetUserProfile(token: jwtToken)
                    try await appData.getUserCart(token: jwtToken)
                    try await appData.getUserWistList(token: jwtToken)
                } catch {
                    appData.error = error.localizedDescription
                    appData.isShowingAlert = true
                    print("Error during Github sign-in:", error)
                }
                appData.isLoading = false
            }
        }
    }
}

#Preview {
    GithubLoginButtonView(viewModel: LoginViewModel())
}
