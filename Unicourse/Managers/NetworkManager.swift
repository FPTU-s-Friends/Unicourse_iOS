//
//  NetworkManager.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
//    private let baseURL = "http://localhost:4040"
    
    private let baseURL = "https://unicourse-api-production.up.railway.app"

    private init() {}

    // MARK: - Public Methods

    func signIn(email: String, completion: @escaping (Result<SignInResponseModel, Error>) -> Void) {
        let path = APIPath.signIn.stringValue
        let method = HTTPMethod.post
        let headers = ["Content-Type": "application/json"]

        // Tạo SignInRequestModel từ email
        let signInRequest = SignInRequestModel(email: email)

        // Mã hóa SignInRequestModel thành dạng Data
        guard let bodyData = try? JSONEncoder().encode(signInRequest) else {
            completion(.failure(NSError(domain: "Invalid request data", code: 0, userInfo: nil)))
            return
        }

        // Gọi API với dữ liệu đã mã hóa
        callAPI(path: path, method: method, headers: headers, body: bodyData, completion: completion)
    }

    func signUp(email: String, fullName: String, profileImage: String, completion: @escaping (Result<SignUpResponseModel, Error>) -> Void) {
        let path = APIPath.signUp.stringValue
        let method = HTTPMethod.post
        let headers = ["Content-Type": "application/json"]

        let signUpRequest = SignUpRequestModel(email: email, fullName: fullName, profileImage: profileImage)

        dump(signUpRequest)

        guard let bodyData = try? JSONEncoder().encode(signUpRequest) else {
            completion(.failure(NSError(domain: "Invalid Request Sign Up Data", code: 0, userInfo: nil)))
            return
        }
        callAPI(path: path, method: method, headers: headers, body: bodyData, completion: completion)
    }

    // MARK: - Private Methods

    private func callAPI<T: Codable>(path: String, method: HTTPMethod, headers: [String: String]?, body: Data?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL)?.appendingPathComponent(path) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        let request = HTTPRequest(url: url, method: method, headers: headers, body: body)
        HTTPClient.shared.sendRequest(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(response))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
