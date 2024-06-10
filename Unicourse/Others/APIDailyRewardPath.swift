//
//  APIDailyRewardPath.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/6/24.
//

import Foundation

enum APIDailyRewardPath {
    case getListCheckingDaily

    var endPointValue: String {
        switch self {
        case .getListCheckingDaily:
            "/api/checkingDaily"
        }
    }
}
