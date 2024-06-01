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
    case blog = "Bài viết"
    case account = "Tài khoản"

    var systemImage: String {
        switch self {
            case .home:
                return "house.fill"
            case .course:
                return "book.fill"
            case .quiz:
                return "puzzlepiece.extension.fill"
            case .blog:
                return "newspaper.fill"
            case .account:
                return "person.crop.circle.fill"
        }
    }

    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
