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

    func signInWithGoogle(idToken: String, accessToken: String, completion: @escaping (Result<String, Error>) -> Void) async throws {
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        do {
            let authDataResult = try await Auth.auth().signIn(with: credential)
            
            guard let email = authDataResult.user.email else {
                throw AppError.invalidEmail
            }
            
            guard let fullName = authDataResult.user.displayName else {
                throw AppError.invalidFullName
            }
            
            NetworkManager.shared.signIn(email: email) { result in
                switch result {
                case .success(let signInResponse):
                    // Extract the access token from signInResponse
                    let accessToken = signInResponse.data.accessToken
                    completion(.success(accessToken))
                    
                case .failure:
                    // If signIn fails, try signUp
                    NetworkManager.shared.signUp(email: email, fullName: fullName, profileImage: authDataResult.user.photoURL?.absoluteString ?? "") { signUpResult in
                        switch signUpResult {
                        case .success(let signUpResponse):
                            // Extract the access token from signUpResponse
                            let accessToken = signUpResponse.data.accessToken
                            completion(.success(accessToken))
                            
                        case .failure(let signUpError):
                            print("Error API:", signUpError)
                            // Call completion handler with the signUpError
                            completion(.failure(signUpError))
                        }
                    }
                }
            }
        } catch {
            // If signIn throws an error, call completion handler with the error
            completion(.failure(error))
        }
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}
