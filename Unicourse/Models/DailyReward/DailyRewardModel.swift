//
//  DailyRewardModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/6/24.
//

import Foundation

struct DailyRewardModel: Codable, Identifiable {
    var id: String { _id }
    let _id: String
    let title: String
    let description: String
    let coin: Int
    let list_users: [String]
    let day: String

    static let mockData = [
        DailyRewardModel(_id: "0", title: "Điểm danh hằng ngày", description: "Sự kiện điểm danh hằng tuần", coin: 100, list_users: [
            "665e928f01f6629b5005d779",
            "6646f84216457d365c09d6d6"], day: "2024-06-10T10:27:00.021Z"),
        DailyRewardModel(_id: "1", title: "Điểm danh hằng ngày", description: "Sự kiện điểm danh hằng tuần", coin: 100, list_users: [], day: "2024-06-11T10:27:00.021Z"),
        DailyRewardModel(_id: "2", title: "Điểm danh hằng ngày", description: "Sự kiện điểm danh hằng tuần", coin: 100, list_users: [], day: "2024-06-12T10:27:00.021Z"),
        DailyRewardModel(_id: "3", title: "Điểm danh hằng ngày", description: "Sự kiện điểm danh hằng tuần", coin: 100, list_users: [], day: "2024-06-13T10:27:00.021Z"),
        DailyRewardModel(_id: "4", title: "Điểm danh hằng ngày", description: "Sự kiện điểm danh hằng tuần", coin: 100, list_users: [], day: "2024-06-14T10:27:00.021Z"),
        DailyRewardModel(_id: "5", title: "Điểm danh hằng ngày", description: "Sự kiện điểm danh hằng tuần", coin: 100, list_users: [], day: "2024-06-15T10:27:00.021Z"),
        DailyRewardModel(_id: "6", title: "Điểm danh hằng ngày", description: "Sự kiện điểm danh hằng tuần", coin: 100, list_users: [], day: "2024-06-16T10:27:00.021Z")
    ]
}
