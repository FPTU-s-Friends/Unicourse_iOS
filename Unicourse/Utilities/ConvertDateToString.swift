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
