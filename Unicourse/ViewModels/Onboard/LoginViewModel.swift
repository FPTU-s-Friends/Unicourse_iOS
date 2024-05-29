//
//  LoginViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Firebase
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
}
