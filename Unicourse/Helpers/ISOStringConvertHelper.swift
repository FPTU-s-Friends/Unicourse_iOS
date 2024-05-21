//
//  ISOStringConvertHelper.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 21/5/24.
//

import Foundation

func formatDateToMonthDay(dateString: String) -> String? {
    // Create a DateFormatter to parse the input string
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    inputFormatter.timeZone = TimeZone(abbreviation: "UTC")

    // Parse the input date string
    guard let date = inputFormatter.date(from: dateString) else {
        return nil
    }

    // Create a DateFormatter to format the date as "Month Day"
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "MMM d"
    outputFormatter.timeZone = TimeZone.current

    // Format the date
    return outputFormatter.string(from: date)
}

func formatDateToHourMinute(dateString: String) -> String? {
    // Create a DateFormatter to parse the input string
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    inputFormatter.timeZone = TimeZone(abbreviation: "UTC")

    // Parse the input date string
    guard let date = inputFormatter.date(from: dateString) else {
        return nil
    }

    // Create a DateFormatter to format the date as "Hour:Minute"
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "HH:mm"
    outputFormatter.timeZone = TimeZone.current

    // Format the date
    return outputFormatter.string(from: date)
}
