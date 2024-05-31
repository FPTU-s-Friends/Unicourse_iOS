//
//  Tab.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import Foundation

enum Tab: String, CaseIterable {
    case home = "Trang chủ"
    case course = "Khoá học"
    case quiz = "Ôn tập"
    case community = "Cộng đồng"
    case account = "Tài khoản"

    var systemImage: String {
        switch self {
            case .home:
                return "house.fill"
            case .course:
                return "book.fill"
            case .quiz:
                return "puzzlepiece.extension.fill"
            case .community:
                return "person.3.fill"
            case .account:
                return "person.crop.circle.fill"
        }
    }

    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
