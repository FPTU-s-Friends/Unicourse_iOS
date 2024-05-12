//
//  Color+Extension.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/5/24.
//

import SwiftUI

extension Color {
    static var mainColor1 = Color(hex: "5EDFF5")
    static var mainColor2 = Color(hex: "9F80F8")
    static var activeColor = Color(hex: "2C9FFF")
    static var activeButtonColor = Color(hex: "4284F4")
    static var mainBackgroundColor = Color(hex: "F3FBFF")
    static var neutralTextColor = Color(hex: "#8D8A8A")

    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)

        self.init(red: Double((rgb & 0xFF0000) >> 16) / 255.0,
                  green: Double((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: Double(rgb & 0x0000FF) / 255.0)
    }
}
