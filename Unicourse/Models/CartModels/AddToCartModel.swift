//
//  AddToCartModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 18/6/24.
//

import Foundation

struct AddToCartResponseModel: Codable {
    let _id: String
    let user_id: AddToCartUserResponseModel
    let amount: Int
    let created_at: String
    let items: [AddToCartItemsResponseModel]
}

struct AddToCartUserResponseModel: Codable {
    let _id: String
    let email: String
}

struct AddToCartItemsResponseModel: Codable {
    let _id: String
    let title: String
    let amount: Int
    let thumbnail: String
}
