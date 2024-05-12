//
//  AppData.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Foundation
import JWTDecode

class AppData: ObservableObject {
    @Published var user: UserProfile?
    @Published var token: String
    @Published var isShowingAlert = false
    @Published var isLoading = false
    @Published var error: String = ""

    init(user: UserProfile? = nil, token: String = "") {
        self.user = user
        self.token = token
    }

    func decodeJWTTokenAndSetUserProfile(token: String) {
        do {
            // Decoding the JWT token
            let jwt = try JWTDecode.decode(jwt: token)

            // Extracting user information from the JWT claims
            let userId = jwt.claim(name: "_id").string ?? ""
            let fullName = jwt.claim(name: "fullName").string ?? ""
            let email = jwt.claim(name: "email").string ?? ""
            let profileImage = jwt.claim(name: "profile_image").string ?? ""
            let role = jwt.claim(name: "role").string ?? ""

            // Updating the user profile in appData
            self.user = UserProfile(userId: userId, email: email, fullName: fullName, profileImageURL: URL(string: profileImage), role: role)
        } catch {
            print(error)
        }
    }
}
