//
//  AuthenticationManager.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import FirebaseAuth
import Foundation

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
}
