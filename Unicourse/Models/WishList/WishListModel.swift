//
//  WishListModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 3/7/24.
//

import Foundation

struct WishListModel: Codable {
    let _id: String
    let title: String
    let titleDescription: String
    let subTitle: String
    let subTitleDescription: [String]
    let type: CourseEnrollType
    let amount: Int
    let thumbnail: String
    let lecture: lectureWishListModel
}

struct lectureWishListModel: Codable {
    let _id: String
    let fullName: String
    let profileName: String
    let profile_image: String
}
