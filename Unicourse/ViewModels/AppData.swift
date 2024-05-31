//
//  AppData.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Firebase
import Foundation
import JWTDecode

class AppData: ObservableObject {
    @Published var user: UserProfile?
    @Published var userInfo: UserInfoModel?
    @Published var token: String
    @Published var isShowingAlert = false
    @Published var isLoading = false
    @Published var isShowSlashScreen = true
    @Published var error: String = ""
    @Published var mainTabSelection = 0
    @Published var isLoggedIn: Bool = false
    @Published var listCurrentEnrolled: [String] = []

    init(user: UserProfile? = nil, token: String = "") {
        self.user = user
        self.token = token
    }

    func decodeJWTTokenAndSetUserProfile(token: String) async throws {
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
            user = UserProfile(userId: userId, email: email, fullName: fullName, profileImageURL: URL(string: profileImage), role: UserRole(rawValue: role) ?? .student)
            self.token = token
            try await getUserInfo(userId: userId, token: token)
        } catch {
            print(error)
        }
    }

    func signOutUser() throws {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            user = nil
            userInfo = nil
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    func showAlert(text: String) {
        DispatchQueue.main.async {
            self.isShowingAlert = true
            self.error = text
        }
    }

    // Kiểm tra trạng thái đăng nhập của người dùng
//    func checkUserAuthentication() async throws {
//        if let email = Auth.auth().currentUser?.email {
//            isLoggedIn = true
//            NetworkManager.shared.signIn(email: email) { result in
//                switch result {
//                case let .success(data):
//                    printJSONData(data: data)
//                    let accessToken = data.data.accessToken.split(separator: " ")[1]
//                    self.token = String(accessToken)
//                    self.decodeJWTTokenAndSetUserProfile(token: String(accessToken))
//
//                case let .failure(error):
//                    self.isShowingAlert = true
//                    self.error = error.localizedDescription
//                }
//            }
//        }
//    }

    func checkUserAuthentication() async throws {
        guard let email = Auth.auth().currentUser?.email else {
            return // No user logged in, handle as needed (e.g., show login)
        }

        do {
            let data = try await NetworkManager.shared.signIn(email: email)

            let accessToken = data.data.accessToken

            let tokenSplitString = accessToken.split(separator: " ")[1]
            token = String(tokenSplitString)
            try await decodeJWTTokenAndSetUserProfile(token: String(tokenSplitString))
            isLoggedIn = true
        } catch {
            isShowingAlert = true
            self.error = error.localizedDescription
            throw error
        }
    }

    func fetchUserInfo(userId: String, token: String) async throws -> CommonResponse<UserInfoModel> {
        let path = "\(APIPath.getUserInfo.stringValue)/\(userId)"
        let method = HTTPMethod.get
        let headers = ["Authorization": "Bearer \(token)"]

        return try await NetworkManager.shared.callAPI(path: path, method: method, headers: headers, body: nil)
    }

    func getUserInfo(userId: String, token: String) async throws {
        do {
            let data = try await fetchUserInfo(userId: userId, token: token)
            userInfo = data.data
        } catch {
            print("Get User Info Error")
            self.error = error.localizedDescription
            isShowingAlert = true
            print(error)
        }
    }
}
