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
    @ObservedObject var viewModel: LoginViewModel

    @State var error = ""

    var body: some View {
        VStack {
            SignInWithAppleButton(.signIn) { request in
                // Set requestedScopes and nonce
                viewModel.currentNonce = randomNonceString()
                request.requestedScopes = [.email]
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
                            try await viewModel.signInWithApple(credential: credential)
                        } catch {
                            print("Apple sign-in error: \(error.localizedDescription)")
                            self.error = error.localizedDescription
                        }
                    }
                case .failure(let error):
                    print("Apple sign-in error: \(error.localizedDescription)")
                    self.error = error.localizedDescription
                }
            }
        }
        .frame(height: 55)
        .padding(.horizontal, 25)
        .clipShape(.capsule)
//        .overlay {
//            VStack {
//                ButtonLoginView(action: {}, iconImage: "appleIcon", textDetail: "Đăng nhập với Apple")
//            }
//            .allowsHitTesting(false)
//        }
    }
}

#Preview {
    AppleLoginButtonView(viewModel: LoginViewModel())
}
