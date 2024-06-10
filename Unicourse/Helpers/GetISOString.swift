//
//  GetISOString.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/6/24.
//

import Foundation

func getCurrentDateAsISOString() -> String {
    let currentDate = Date()
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [
        .withInternetDateTime,
        .withFractionalSeconds,
        .withDashSeparatorInDate,
        .withColonSeparatorInTime,
        .withTimeZone
    ]
    let isoString = isoFormatter.string(from: currentDate)
    return isoString
}

func areDatesEqualIgnoringTime(_ isoDateString1: String, _ isoDateString2: String) -> Bool {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    guard let date1 = isoFormatter.date(from: isoDateString1),
          let date2 = isoFormatter.date(from: isoDateString2)
    else {
        return false
    }

    let calendar = Calendar.current
    let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
    let components2 = calendar.dateComponents([.year, .month, .day], from: date2)

    return components1.year == components2.year &&
        components1.month == components2.month &&
        components1.day == components2.day
}
