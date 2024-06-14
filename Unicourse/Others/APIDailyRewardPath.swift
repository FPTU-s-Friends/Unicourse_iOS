//
//  APIDailyRewardPath.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/6/24.
//

import Foundation

enum APIDailyRewardPath {
    case getListCheckingDaily
    case getTotalCoin
    case claimCoinToday(daily_id: String)

    var endPointValue: String {
        switch self {
        case .getListCheckingDaily:
            "/api/checkingDaily"
        case .getTotalCoin:
            "/api/coins/get-total-coin"
        case .claimCoinToday(let daily_id):
            "/api/checkingDaily/mark/\(daily_id)"
        }
    }
}
