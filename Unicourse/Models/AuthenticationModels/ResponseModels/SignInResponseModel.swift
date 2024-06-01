//
//  SignInResponseModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Foundation

struct SignInResponseModel: Codable {
    let message: String
    let status: Int
    let data: SignInResponseData
}

struct SignInResponseData: Codable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
