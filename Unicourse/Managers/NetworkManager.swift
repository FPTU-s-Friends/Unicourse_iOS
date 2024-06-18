//
//  NetworkManager.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidBaseURL
    case invalidResponse(URLResponse?)
    case decodingError(Error)
    case encodingError
    case invalidHTTPStatusCode(Int)
}

class NetworkManager {
    static let shared = NetworkManager()
//    private let baseURL = "https://unicourse-server-test.up.railway.app"
    private let baseURL = "https://unicourse-api-production.up.railway.app"

    // MARK: - Public Methods

    func signIn(email: String) async throws -> SignInResponseModel { // Change return type
        let path = APIPath.signIn.stringValue
        let method = HTTPMethod.post
        let headers = ["Content-Type": "application/json"]

        let signInRequest = SignInRequestModel(email: email)
        guard let bodyData = try? JSONEncoder().encode(signInRequest) else {
            throw NetworkError.encodingError // Use custom error
        }

        return try await callAPI(path: path, method: method, headers: headers, body: bodyData) // Await result
    }

    func signUp(email: String, fullName: String, profileImage: String) async throws -> SignUpResponseModel {
        let path = APIPath.signUp.stringValue
        let method = HTTPMethod.post
        let headers = ["Content-Type": "application/json"]

        let signUpRequest = SignUpRequestModel(email: email, fullName: fullName, profileImage: profileImage)

        guard let bodyData = try? JSONEncoder().encode(signUpRequest) else {
            throw NetworkError.encodingError // Use a custom error
        }

        return try await callAPI(path: path, method: method, headers: headers, body: bodyData) // Await result
    }

    // MARK: - Call API Method

    func callAPI<T: Codable>(path: String, method: HTTPMethod, headers: [String: String]? = nil, parameters: [String: Any]? = nil, body: Data?) async throws -> T {
        print(path)
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw NetworkError.invalidBaseURL
        }

        urlComponents.path = path

        if let parameters = parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        var defaultHeaders = ["Content-Type": "application/json"]
        if let additionalHeaders = headers {
            defaultHeaders.merge(additionalHeaders) { _, new in new }
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = defaultHeaders
        request.httpBody = body

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse(response)
            }

            if !(200 ... 299).contains(httpResponse.statusCode) {
                throw NetworkError.invalidHTTPStatusCode(httpResponse.statusCode)
            }

            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }

    func callAPI2<T: Codable>(path: String, method: HTTPMethod, headers: [String: String]? = nil, parameters: [String: Any]? = nil, body: Data?, completion: @escaping (Result<T, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid Base URL", code: 0, userInfo: nil)))
            return
        }

        urlComponents.path = path

        // Add parameters if available
        if let parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }

        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        // Headers mặc định
        var defaultHeaders = ["Content-Type": "application/json"]
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
