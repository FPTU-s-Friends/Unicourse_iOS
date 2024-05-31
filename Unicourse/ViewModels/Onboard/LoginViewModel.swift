//
//  LoginViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

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
        do {
            // Attempt to sign in with GitHub
            let accessToken = try await AuthenticationManager.shared.signInWithGitHub()

            // Fetch user details from GitHub
            let email = try await AuthenticationManager.shared.fetchGithubEmail(accessToken: accessToken)
            let (name, image) = try await AuthenticationManager.shared.fetchGithubUserInfo(accessToken: accessToken)

            // Try signing in with the obtained email
            do {
                let signInResponse = try await NetworkManager.shared.signIn(email: email)
                return signInResponse.data.accessToken
            } catch AuthenticationError.userNotFound {
                // If user not found, try signing up
                let signUpResponse = try await NetworkManager.shared.signUp(
                    email: email,
                    fullName: name,
                    profileImage: image
                )
                return signUpResponse.data.accessToken
            }
        } catch {
            // Handle other errors
            throw error
        }
    }
}
