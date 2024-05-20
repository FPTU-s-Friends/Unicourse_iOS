//
//  CommonResponseType.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 18/5/24.
//

import Foundation

struct CommonResponseType<T: Codable>: Codable {
    var message: String
    var status: Int
    var data: T
}
