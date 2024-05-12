//
//  PageModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/5/24.
//

import Foundation

struct OnboardModel: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var sampleOnboard = OnboardModel(name: "Title", description: "Description", imageUrl: "banner2", tag: 0)

    static var pageBanners: [OnboardModel] = [
        OnboardModel(name: "Học Tập Dễ Dàng", description: "Học theo cách của riêng bạn với các bài học tương tác và giao diện trực quan.", imageUrl: "banner1", tag: 0),
        OnboardModel(name: "Học Tập Mọi Lúc", description: "Khám phá người bạn đồng hành hướng dẫn bạn trong suốt hành trình học tập", imageUrl: "banner2", tag: 1),
        OnboardModel(name: "Theo Dõi Tiến Trình", description: "Luôn cập nhật mục tiêu của bạn bằng số liệu phân tích và hiệu suất.", imageUrl: "banner3", tag: 2)
    ]
}
