//
//  AppleLoginButtonView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 31/5/24.
//

import AuthenticationServices
import SwiftUI

struct AppleLoginButtonView: View {
    var body: some View {
        VStack {
            SignInWithAppleButton(.signIn) { request in
                // Handle authorization request if needed
                request.requestedScopes = [.email, .fullName]
            } onCompletion: { result in
                switch result {
                    case .success(let authorization):
                        signInWithApple(authorization)
                    case .failure(let error):
                        print(error)
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

    private func signInWithApple(_ authorization: ASAuthorization) {
        // Perform sign-in with Apple logic here
    }
}

#Preview {
    AppleLoginButtonView()
}
