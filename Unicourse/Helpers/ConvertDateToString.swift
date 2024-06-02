//
//  ConvertDateToString.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 17/5/24.
//

import Foundation

func convertMinutesToString(minutes: Int) -> String {
    let hours = minutes / 60
    let remainingMinutes = minutes % 60

    var result = "Khoảng "

    if hours > 0 {
        result += "\(hours) giờ"
    }

    if remainingMinutes > 0 {
        if hours > 0 {
            result += " "
        }
        result += "\(remainingMinutes) phút"
    }

    return result
}

func timeSinceCreated(date: String? = nil) -> String {
    guard let createdDateString = date else { return "Ngày tạo không hợp lệ" }

    // Define a date formatter to parse the date string
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Adjust the format to match your date string

    // Convert the string to a Date
    guard let createdDate = dateFormatter.date(from: createdDateString) else {
        return "Ngày tạo không hợp lệ"
    }

    let calendar = Calendar.current
    let now = Date()
    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: createdDate, to: now)

    if let years = components.year, years > 0 {
        return "\(years) năm trước"
    } else if let months = components.month, months > 0 {
        return "\(months) tháng trước"
    } else if let days = components.day, days > 0 {
        return "\(days) ngày trước"
    } else if let hours = components.hour, hours > 0 {
        return "\(hours) giờ trước"
    } else if let minutes = components.minute, minutes > 0 {
        return "\(minutes) phút trước"
    } else {
        return "Vừa xong"
    }
}
