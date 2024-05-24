//
//  DefaultValue.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 24/5/24.
//

import Foundation

enum Order {
    case DES
    case ASC

    var toString: String {
        switch self {
        case .DES:
            return "desc"
        case .ASC:
            return "asc"
        }
    }
}
