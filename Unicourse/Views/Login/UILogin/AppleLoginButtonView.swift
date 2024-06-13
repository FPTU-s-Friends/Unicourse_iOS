//
//  AppleLoginButtonView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 31/5/24.
//

import AuthenticationServices
import Firebase
import SwiftUI

struct AppleLoginButtonView: View {
    @EnvironmentObject var appData: AppData
    @ObservedObject var viewModel: LoginViewModel
    @State var error = ""

    var body: some View {
        VStack {
            SignInWithAppleButton(.continue) { request in

                // Set requestedScopes and nonce
                viewModel.currentNonce = randomNonceString()
                request.requestedScopes = [.email, .fullName]
                request.nonce = sha256(viewModel.currentNonce)

            } onCompletion: { result in
                switch result {
                case .success(let authorization):
                    guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                        print("Error with Firebase.")
                        error = "Error with Firebase."
                        return
                    }

                    Task {
                        do {
                            appData.isLoading = true
                            let token = try await viewModel.signInWithApple(credential: credential)
                            let jwtToken = String(token.split(separator: " ")[1])
                            appData.token = jwtToken
                            try await appData.decodeJWTTokenAndSetUserProfile(token: jwtToken)
                            try await appData.getUserCart(token: jwtToken)
                        } catch {
                            print("Apple sign-in error: \(error.localizedDescription)")
                            self.error = "Apple sign-in error: \(error.localizedDescription)"
                            appData.isShowingAlert = true
                        }
                        appData.isLoading = false
                    }
                case .failure(let error):
                    print("Apple sign-in error: \(error.localizedDescription)")
                    self.error = "Apple sign-in error: \(error.localizedDescription)"
                    appData.isShowingAlert = true
                }
            }
        }
        .frame(height: 55)
        .padding(.horizontal, 25)
        .clipShape(.capsule)
        .overlay {
            VStack {
                ButtonLoginView(action: {}, iconImage: "appleIcon", textDetail: "Đăng nhập với Apple")
            }
            .allowsHitTesting(false)
        }
    }
}

#Preview {
    AppleLoginButtonView(viewModel: LoginViewModel())
}
