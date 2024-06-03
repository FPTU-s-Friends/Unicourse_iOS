//
//  AuthenticationManager.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import FirebaseAuth

import Foundation

enum AuthenticationError: Error {
    case userNotFound
    //  Other authentication-related     errors
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()

    func signInWithGoogle(idToken: String, accessToken: String) async throws -> String {
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

        do {
            let authDataResult = try await Auth.auth().signIn(with: credential)

            guard let email = authDataResult.user.email else {
                throw AppError.invalidEmail
            }
            guard let fullName = authDataResult.user.displayName else {
                throw AppError.invalidFullName
            }

            do {
                let signInResponse = try await NetworkManager.shared.signIn(email: email)
                return signInResponse.data.accessToken
            } catch {
                // If sign-in fails, try sign-up
                let profileImage = authDataResult.user.photoURL?.absoluteString ?? ""
                let signUpResponse = try await NetworkManager.shared.signUp(
                    email: email,
                    fullName: fullName,
                    profileImage: profileImage
                )
                return signUpResponse.data.accessToken
            }

        } catch {
            // Handle general authentication errors here
            throw error // Re-throw if it's not handled here
        }
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }

    func signInWithGitHub() async throws -> String {
        let provider = OAuthProvider(providerID: "github.com")
        provider.scopes = ["user:email"]
        provider.customParameters = ["allow_signup": "true"]

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

    func fetchGithubEmail(accessToken: String) async throws -> String {
        let url = URL(string: "https://api.github.com/user/emails")!
        var request = URLRequest(url: url)
        request.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")

        let (data, _) = try await URLSession.shared.data(for: request)

        guard let emails = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
              let primaryEmail = emails.first(where: { $0["primary"] as? Bool == true })?["email"] as? String
        else {
            let error = NSError(domain: "fetchGithubEmail", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable to find primary email in GitHub API response"])
            throw error
        }

        return primaryEmail
    }

    func fetchGithubUserInfo(accessToken: String) async throws -> (String, String) {
        let url = URL(string: "https://api.github.com/user")!
        var request = URLRequest(url: url)
        request.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")

        let (data, _) = try await URLSession.shared.data(for: request)

        guard let userData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let name = userData["name"] as? String,
              let avatarURL = userData["avatar_url"] as? String
        else {
            throw NSError(domain: "fetchGithubUserInfo", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unable to find user info in GitHub API response"])
        }

        return (name, avatarURL)
    }
}
