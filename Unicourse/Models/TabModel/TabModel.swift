//
//  TabModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/5/24.
//

import SwiftUI

struct TabModel: Identifiable {
    private(set) var id: Tab
    var size: CGSize = .zero
    var minX: CGFloat = .zero

    enum Tab: String, CaseIterable {
        case detail = "Chi tiết"
        case journey = "Lộ trình"
        case review = "Đánh giá"
    }
}
