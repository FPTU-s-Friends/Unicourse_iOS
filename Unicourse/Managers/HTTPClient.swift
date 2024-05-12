//
//  HTTPClient.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct HTTPRequest {
    let url: URL
    let method: HTTPMethod
    let headers: [String: String]?
    let body: Data?
}


class HTTPClient {
    static let shared = HTTPClient()

    private init() {}

    func sendRequest(_ request: HTTPRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                let unknownError = NSError(domain: "Unknown Error", code: 0, userInfo: nil)
                completion(.failure(unknownError))
                return
            }

            guard (200 ... 299).contains(httpResponse.statusCode) else {
                let statusCodeError = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
                completion(.failure(statusCodeError))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "No Data", code: 0, userInfo: nil)
                completion(.failure(noDataError))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }
}
