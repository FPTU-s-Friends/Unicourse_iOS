//
//  ClaimCoin.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 13/6/24.
//

struct ClaimCoinResponse: Codable {
    let title: String
    let description: String
    let coin: Int
    let type: String
    let status: String
    let date_used: String?
    let _id: String
}
