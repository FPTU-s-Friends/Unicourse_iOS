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

func isDate(_ dateString1: String, lessThan dateString2: String) -> Bool {
    let dateFormatter = ISO8601DateFormatter()

    if let date1 = dateFormatter.date(from: dateString1), let date2 = dateFormatter.date(from: dateString2) {
        return date1 < date2
    } else {
        // Handle invalid date strings if needed
        return false
    }
}

func compareDates(_ dateString1: String, todayDate dateString2: String) -> Int {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withFullDate]

    guard let date1 = dateFormatter.date(from: dateString1),
          let todayDate = dateFormatter.date(from: dateString2)
    else {
        // Handle invalid date strings if needed
        return -1 // Return -1 to indicate an error
    }

    let calendar = Calendar.current

    if calendar.isDate(date1, inSameDayAs: todayDate) {
        return 0 // date1 is today
    } else if date1 < todayDate {
        return 1 // date1 is in the past
    } else {
        return 2 // date1 is in the future
    }
}
