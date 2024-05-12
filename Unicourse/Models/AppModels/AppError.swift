//
//  AppError.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Foundation

enum AppError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case networkError(String)
    case invalidEmail
    case invalidFullName
    // Các trường hợp lỗi khác có thể được thêm vào đây
}

enum HTTPError: Error {
    case statusCode(Int)
    case invalidResponse
    case decodingError(Error)
    // Add more cases as needed
}
