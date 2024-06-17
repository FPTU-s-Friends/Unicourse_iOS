//
//  APIKeyAI.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 14/6/24.
//

import Foundation

// Cấu trúc APIKey
enum APIKey {
    static let `default`: String = {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-info", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist["GEMINI_API_KEY"] as? String
        else {
            fatalError("Không tìm thấy API Key trong file GenerativeAI-info.plist")
        }
        return value
    }()
    
    static let `OPENAI`: String = {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-info", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist["OPENAI_API_KEY"] as? String
        else {
            fatalError("Không tìm thấy API Key trong file GenerativeAI-info.plist")
        }
        return value
    }()
    
}
