//
//  CartModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 9/6/24.
//

import Foundation

struct CartModel: Codable {
    let _id: String
    let user_id: CartUser_idModel
    let amount: Int
    let items: [CartItem]
    let created_at: String
    let updated_at: String
}

struct CartUser_idModel: Codable {
    let _id: String
    let email: String
}

struct CartItem: Codable {
    let _id: String
    let title: String
    let amount: Int
    let thumbnail: String

    static var sampleData = CartItem(_id: "65a8791ea30979a347d026ca",
                                     title: "Khóa học PRF192",
                                     amount: 2000,
                                     thumbnail: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Course%2FCN1%2Fc.jpg?alt=media&token=e4bf4de1-fe0b-4eb3-b4db-42ecdcd9ea06")
}
