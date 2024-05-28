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

//        dump(signUpRequest)

        guard let bodyData = try? JSONEncoder().encode(signUpRequest) else {
            completion(.failure(NSError(domain: "Invalid Request Sign Up Data", code: 0, userInfo: nil)))
            return
        }
        callAPI(path: path, method: method, headers: headers, body: bodyData, completion: completion)
    }

    // MARK: - Course Method

    // MARK: - Private Methods

    func callAPI<T: Codable>(path: String, method: HTTPMethod, headers: [String: String]?, body: Data?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL)?.appendingPathComponent(path) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        let request = HTTPRequest(url: url, method: method, headers: ["Content-Type": "application/json"], body: body)
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

    // đây là function call mới => đặt tạm là callApi2
    // đặt một list cặp key - value vào cái biến r đưa vào đối số headers là được
//    additionalHeaders = [
//        "Authorization": "Bearer token",
//        "Accept": "application/json"
//    ]

    func callAPI2<T: Codable>(path: String, method: HTTPMethod, headers: [String: String]? = nil, parameters: [String: Any]? = nil, body: Data?, completion: @escaping (Result<T, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid Base URL", code: 0, userInfo: nil)))
            return
        }

        urlComponents.path = path

        // Add parameters if available
        if let parameters = parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }

        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        // Headers mặc định
        var defaultHeaders = ["Content-Type": "application/json"]
        // Hợp nhất headers mặc định với headers được truyền vào (nếu có)
        if let additionalHeaders = headers {
            defaultHeaders.merge(additionalHeaders) { _, new in new }
        }

        let request = HTTPRequest(url: url, method: method, headers: defaultHeaders, body: body)
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
