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
    @Published var cart: CartModel?
    @Published var listCurrentEnrolled: [String] = []
    @Published var wishList: [WishListModel] = []
    @Published var token: String
    @Published var isShowingAlert = false
    @Published var isShowingAlertUpdateUser = false
    @Published var isLoggedIn: Bool = false
    @Published var isLoading = false
    @Published var isShowSlashScreen = true
    @Published var error: String = ""
    @Published var mainTabSelection = 0

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
            cart = nil
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

    func checkUserAuthentication() async throws {
        guard let email = Auth.auth().currentUser?.email else {
            return
        }

        do {
            print(email)
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
            if data.data != nil {
                userInfo = data.data
            }
        } catch {
            print("Get User Info Error")
            self.error = error.localizedDescription
            isShowingAlert = true
            print(error)
        }
    }

    func getUserCart(token: String) async throws {
        let path = APIPath.getUserCart.stringValue
        let method = HTTPMethod.get
        let headers = ["Authorization": "Bearer \(token)"]

        do {
            let response: CommonResponse<CartModel> = try await NetworkManager.shared.callAPI(path: path, method: method, headers: headers, body: nil)
            if let data: CartModel = response.data {
                cart = data
            } else {
                print("User cart data is nil")
            }

        } catch {
            cart = nil
            print("Get User Cart Error")
            print(error)
        }
    }

    func getUserWistList(token: String) async throws {
        let path = APIPath.getWishList.stringValue
        let method = HTTPMethod.get
        let headers = ["Authorization": "Bearer \(token)"]

        do {
            let response: CommonResponse<[WishListModel]> = try await NetworkManager.shared.callAPI(path: path, method: method, headers: headers, body: nil)
            if let data: [WishListModel] = response.data {
                wishList = data
            } else {
                print("Wishlist data is nil")
            }
        } catch {
            print("Get wish list error")
            print(error)
            self.error = error.localizedDescription
            isShowingAlert = true
        }
    }

    func updateUserProfile(newInfor: requestUpdateUserProfile, token: String, userId: String) async throws {
        let path = APIPath.updateUser.stringValue
        let method = HTTPMethod.put
        let headers = ["Authorization": "Bearer \(token)"]

        do {
            let encoder = JSONEncoder()
            let bodyData = try encoder.encode(newInfor)
            let response: CommonResponse<ResponseUpdateUserProfile> = try await NetworkManager.shared.callAPI(path: "\(path)/\(userId)", method: method, headers: headers, body: bodyData)
            if let data = response.data {
                userInfo?.fullName = data.fullName
                userInfo?.profileImage = data.profileImage
                userInfo?.profileName = data.profileName
                userInfo?.dateOfBirth = data.dateOfBirth
                user?.fullName = data.fullName
            }
        } catch {
            print("UpdateUserProfile", error)
            self.error = error.localizedDescription
            isShowingAlert = true
        }
    }

    func createPaymentLink(token: String, paymentInfo: CreatePaymentLinkModel) async throws -> CommonResponse<PaymentLinkData> {
        let path = APIPath.createPaymentLink.stringValue
        let method = HTTPMethod.post
        let headers = [
            "Authorization": "Bearer \(token)",
            "x-mobile-source": "true"
        ]

        guard let bodyData = try? JSONEncoder().encode(paymentInfo) else {
            throw NetworkError.encodingError
        }

        do {
            let response: CommonResponse<PaymentLinkData> = try await NetworkManager.shared.callAPI(path: path, method: method, headers: headers, body: bodyData)
            return response
        } catch {
            print("createPaymentLinkFailed", error)
            self.error = error.localizedDescription
            isShowingAlert = true
            throw error
        }
    }

    func getPaymentLinkInfo(token: String, orderCode: Int) async throws -> CommonResponse<PaymentLinkInfomation> {
        let path = APIPath.getPaymentInfo.stringValue
        let method = HTTPMethod.get
        let headers = [
            "Authorization": "Bearer \(token)"
        ]

        do {
            let response: CommonResponse<PaymentLinkInfomation> = try await NetworkManager.shared.callAPI(path: "\(path)/\(orderCode)", method: method, headers: headers, body: nil)
            printJSONData(data: response)
            return response
        } catch {
            print("getPaymentLinkInfo", error)
            self.error = error.localizedDescription
            isShowingAlert = true
            throw error
        }
    }

    func createTransaction(token: String, data: TransactionRequestModel) async throws -> CommonResponse<TransactionResponseModel> {
        let path = APIPath.createTransaction.stringValue
        let method = HTTPMethod.post
        let headers = [
            "Authorization": "Bearer \(token)"
        ]

        guard let bodyData = try? JSONEncoder().encode(data) else {
            throw NetworkError.encodingError
        }

        do {
            let response: CommonResponse<TransactionResponseModel> = try await NetworkManager.shared.callAPI(path: path, method: method, headers: headers, body: bodyData)
            printJSONData(data: response)
            return response
        } catch {
            print("create Transaction", error)
            self.error = error.localizedDescription
            isShowingAlert = true
            throw error
        }
    }

    func calculateTotalAmount() -> Int {
        return Int(cart?.items.reduce(0) { $0 + $1.amount } ?? 0)
    }

    func calculateTotalCoin() -> Int {
        return Int(userInfo?.coins?.reduce(0) { $0 + $1.coin } ?? 0)
    }
}

// Payment Link
struct CreatePaymentLinkModel: Codable {
    let orderCode: Int
    let amount: Int
    let description: String
    let items: [itemCreatePaymentModel]
}

struct itemCreatePaymentModel: Codable {
    let name: String
    let quantity: Int
    let price: Int
}

struct PaymentLinkData: Codable {
    let bin: String
    let accountNumber: String
    let accountName: String
    let amount: Int
    let description: String
    let orderCode: Int
    let currency: String
    let paymentLinkId: String
    let status: String
    let checkoutUrl: String
    let qrCode: String
}

struct PaymentLinkInfomation: Codable {
    let id: String
    let orderCode: Int
    let amount: Int
    let amountPaid: Int
    let amountRemaining: Int
    let status: String
    let createdAt: String
    let transactions: [TransactionPaymentLink]
    let canceledAt: String?
    let cancellationReason: String?
}

struct TransactionPaymentLink: Codable {
    let accountNumber: String
    let amount: Int
    let counterAccountBankId: String?
    let counterAccountBankName: String?
    let counterAccountName: String?
    let counterAccountNumber: String?
    let description: String
    let reference: String
    let transactionDateTime: String
    let virtualAccountName: String?
    let virtualAccountNumber: String
}

// Transaction Model
struct TransactionRequestModel: Codable {
    let userId: String
    let process_date: String
    let payer: payerTransaction
    let cart_id: String
    let payment_method: String
    let total_old_amount: Int
    let total_new_amount: Int
    let voucher_id: String
    let status: String
    let transaction_code: String
}

struct payerTransaction: Codable {
    let name: String
    let email: String
    let address: String
}

struct TransactionResponseModel: Codable {
    let userId: String
    let process_date: String
    let payer: payerTransaction
    let item_checkout: [String]?
    let payment_method: String
    let total_old_amount: Int
    let total_new_amount: Int
    let status: String
    let transaction_code: String
}
