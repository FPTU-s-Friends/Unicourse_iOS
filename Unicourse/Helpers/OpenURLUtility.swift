//
//  OpenURLFacebook.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/6/24.
//

import Foundation
import SwiftUI

enum OpenURLUtility {
    // Hàm mở liên kết trong ứng dụng Facebook hoặc Messenger
    static func openURL(_ urlString: String) {
        guard let urlComponents = URLComponents(string: urlString),
              let queryItems = urlComponents.queryItems
        else {
            return
        }

        if urlString.contains("facebook.com") {
            openInFacebookApp(queryItems: queryItems, fallbackURL: urlString)
        } else if urlString.contains("m.me") {
            openInMessengerApp(queryItems: queryItems, fallbackURL: urlString)
        }
    }

    // Mở ứng dụng Facebook nếu có
    private static func openInFacebookApp(queryItems: [URLQueryItem], fallbackURL: String) {
        if let idItem = queryItems.first(where: { $0.name == "id" }),
           let userId = idItem.value,
           let appURL = URL(string: "fb://profile/\(userId)"),
           UIApplication.shared.canOpenURL(appURL)
        {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            if let webURL = URL(string: fallbackURL) {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            }
        }
    }

    // Mở ứng dụng Messenger nếu có
    private static func openInMessengerApp(queryItems: [URLQueryItem], fallbackURL: String) {
        if let idItem = queryItems.first(where: { $0.name == "id" }),
           let userId = idItem.value,
           let appURL = URL(string: "fb-messenger://user-thread/\(userId)"),
           UIApplication.shared.canOpenURL(appURL)
        {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            if let webURL = URL(string: fallbackURL) {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            }
        }
    }
}
