//
//  SemesterModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 24/5/24.
//

import SwiftUI
//s
struct SemesterModel: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color

    static var listSemesters: [SemesterModel] = [
        SemesterModel(name: "Kỳ 1", icon: "book.fill", color: .red),
        SemesterModel(name: "Kỳ 2", icon: "calendar", color: .blue),
        SemesterModel(name: "Kỳ 3", icon: "graduationcap.fill", color: .green),
        SemesterModel(name: "Kỳ 4", icon: "lightbulb.fill", color: .yellow),
        SemesterModel(name: "Kỳ 5", icon: "brain.head.profile.fill", color: .purple),
        SemesterModel(name: "Kỳ 6", icon: "rectangle.3.offgrid.bubble.left.fill", color: .orange),
        SemesterModel(name: "Kỳ 7", icon: "chart.bar.fill", color: .pink),
        SemesterModel(name: "Kỳ 8", icon: "pencil.tip.crop.circle.fill", color: .teal),
        SemesterModel(name: "Kỳ 9", icon: "star.fill", color: .brown)
    ]
}
