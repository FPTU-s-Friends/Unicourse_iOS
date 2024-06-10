//
//  WorkWithWeek.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/6/24.
//

import Foundation

func getVietnameseDayOfWeek(for isoDateString: String) -> String? {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    guard let date = isoFormatter.date(from: isoDateString) else {
        return nil
    }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"

    let dayOfWeek = dateFormatter.string(from: date)
    return convertToVietnameseDay(dayOfWeek: dayOfWeek)
}

func convertToVietnameseDay(dayOfWeek: String) -> String {
    let dayMapping: [String: String] = [
        "Monday": "Thứ 2",
        "Tuesday": "Thứ 3",
        "Wednesday": "Thứ 4",
        "Thursday": "Thứ 5",
        "Friday": "Thứ 6",
        "Saturday": "Thứ 7",
        "Sunday": "Chủ Nhật"
    ]

    return dayMapping[dayOfWeek] ?? dayOfWeek
}
