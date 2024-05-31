//
//  LoginViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Combine
import Firebase
import FirebaseAuth
import FirebaseCore
import Foundation
import GoogleSignIn

@MainActor
final class LoginViewModel: ObservableObject {
    // Define a closure type to pass accessToken
    typealias SignInCompletion = (Result<String, Error>) -> Void

    func signInGoogle() async throws -> String { // Return the accessToken directly
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw URLError(.cannotFindHost)
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let topVC = Utilities.shared.visibleTopViewController() else {
            throw URLError(.cannotFindHost)
        }

        do {
            let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)

            guard let idToken = gidSignInResult.user.idToken?.tokenString else {
                throw URLError(.badServerResponse)
            }
            let accessToken = gidSignInResult.user.accessToken.tokenString

            return try await AuthenticationManager.shared.signInWithGoogle(idToken: idToken, accessToken: accessToken)
        } catch {
            throw error
        }
    }

    func signInGithub() async throws -> String {
        let provider = OAuthProvider(providerID: "github.com")
        provider.scopes = ["user:email"]
        provider.customParameters = ["allow_signup": "true"]

        guard let topVC = Utilities.shared.visibleTopViewController() else {
            throw URLError(.cannotFindHost)
        }

        // Create a Future to encapsulate the async operation
        return try await withCheckedThrowingContinuation { continuation in

            provider.getCredentialWith(nil) { credential, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let credential = credential else {
                    let error = NSError(domain: "signInGithub", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can find credential when login with github"])
                    continuation.resume(throwing: error)
                    return
                }

                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let oauthCredential = authResult?.credential as? OAuthCredential,
                          let accessToken = oauthCredential.accessToken
                    else {
                        let error = NSError(domain: "signInGithub", code: 1, userInfo: [NSLocalizedDescriptionKey: "Can find credential when login with github"])
                        continuation.resume(throwing: error)
                        return
                    }

                    continuation.resume(returning: accessToken)
                }
            }
        }
    }
}
