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

    func decodeJWTTokenAndSetUserProfile(token: String) {
        DispatchQueue.main.async {
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
                self.user = UserProfile(userId: userId, email: email, fullName: fullName, profileImageURL: URL(string: profileImage), role: UserRole(rawValue: role) ?? .student)

                self.getUserInfo(userId: userId, token: token)
            } catch {
                print(error)
            }
        }
    }

    func signOutUser() {
        DispatchQueue.main.async {
            self.isLoggedIn = false
            self.user = nil
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
            decodeJWTTokenAndSetUserProfile(token: String(tokenSplitString))
            isLoggedIn = true
        } catch {
            isShowingAlert = true
            self.error = error.localizedDescription
            throw error
        }
    }

    func getUserInfo(userId: String, token: String) {
        isLoading = true
        NetworkManager.shared.callAPI2(path: "\(APIPath.getUserInfo.stringValue)/\(userId)", method: .get, headers: ["Authorization": "Bearer \(token)"], body: nil) {
            (result: Result<CommonResponse<UserInfoModel>, Error>) in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case let .success(response):
                    switch response.status {
                    case HTTPStatusCodes.OK.rawValue:
                        userInfo = response.data
                    default:
                        print("Get User Info Error")
                    }
                case let .failure(error):
                    self.error = error.localizedDescription
                    isShowingAlert = true
                    print(error)
                }
                isLoading = false
            }
        }
    }
}
