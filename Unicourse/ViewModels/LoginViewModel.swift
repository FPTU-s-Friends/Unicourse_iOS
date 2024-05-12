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

    func signInGoogle(completion: @escaping SignInCompletion) async {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        guard let topVC = Utilities.shared.visibleTopViewController() else {
            completion(.failure(URLError(.cannotFindHost)))
            return
        }

        do {
            let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)

            guard let idToken = gidSignInResult.user.idToken?.tokenString else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            let accessToken = gidSignInResult.user.accessToken.tokenString

            try await AuthenticationManager.shared.signInWithGoogle(idToken: idToken, accessToken: accessToken) { result in
                switch result {
                case .success(let accessTokenFromUC):
                    completion(.success(accessTokenFromUC))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
