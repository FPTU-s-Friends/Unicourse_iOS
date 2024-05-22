//
//  CommonResponse.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/5/24.
//

import Foundation

struct CommonResponse<T: Codable>: Codable {
    let message: String
    let status: Int
    let data: [T]
}
