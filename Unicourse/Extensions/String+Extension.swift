//
//  String+Extension.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import Foundation
import SwiftUI

extension String {
    // Hàm tính toán chiều cao dựa trên chiều rộng và font
    func height(withConstrainedWidth width: CGFloat, font: UIFont = .systemFont(ofSize: 14.0)) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
