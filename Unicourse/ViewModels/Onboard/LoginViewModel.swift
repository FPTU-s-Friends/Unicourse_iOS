//
//  LoginViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import AuthenticationServices
import CryptoKit
import Firebase
import FirebaseAuth
import FirebaseCore
import Foundation
import GoogleSignIn

@MainActor
final class LoginViewModel: NSObject, ObservableObject {
    // Define a closure type to pass accessToken
    @Published var currentNonce = ""
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

    func signInWithApple(credential: ASAuthorizationAppleIDCredential) async throws {
        guard let token = credential.identityToken else {
            throw URLError(.badServerResponse) // Throw an error for better error handling
        }
        guard let tokenString = String(data: token, encoding: .utf8) else {
            throw URLError(.badServerResponse)
        }

        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                          idToken: tokenString,
                                                          rawNonce: currentNonce)
        try await Auth.auth().signIn(with: firebaseCredential) // Use `try await` here
        print("Logged In Success")
    }
}

func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
    }.joined()

    return hashString
}

func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    var randomBytes = [UInt8](repeating: 0, count: length)
    let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
    if errorCode != errSecSuccess {
        fatalError(
            "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
    }

    let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

    let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
    }

    return String(nonce)
}
