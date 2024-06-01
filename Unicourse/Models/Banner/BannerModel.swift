//
//  BannerModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/6/24.
//

import Foundation

enum BannerType: String, Codable {
    case promotion
    case banner
}

enum BannerStatus: String, Codable {
    case active
    case inactive
}

struct BannerModel: Codable {
    let _id: String
    let title: String
    let img: String
    let href: String
    let type: BannerType
    let status: BannerStatus

    static let sampleData = BannerModel(_id: "66572d373e289638404c3d55",
                                        title: "Kỳ mới, Deal Hời",
                                        img: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Baner%2FTo%CC%82%CC%89ng%20ho%CC%9B%CC%A3p%20thie%CC%82%CC%81t%20ke%CC%82%CC%81%20banner.jpg?alt=media&token=c9d4ee1a-1ecf-4fa0-a397-0a6c041bf62c",
                                        href: "https://www.facebook.com/profile.php?id=61559287804624",
                                        type: .promotion,
                                        status: .active)
}
