//
//  SemesterChoosenView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct Semester: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
}

class SemesterData: ObservableObject {
    @Published var semesters: [Semester] = [
        Semester(name: "Kỳ 1", icon: "book.fill"),
        Semester(name: "Kỳ 2", icon: "calendar"),
        Semester(name: "Kỳ 3", icon: "graduationcap.fill"),
        Semester(name: "Kỳ 4", icon: "lightbulb.fill"),
        Semester(name: "Kỳ 5", icon: "brain.head.profile"),
        Semester(name: "Kỳ 6", icon: "rectangle.3.offgrid.bubble.left"),
        Semester(name: "Kỳ 7", icon: "chart.bar.fill"),
        Semester(name: "Kỳ 8", icon: "pencil.and.outline"),
        Semester(name: "Kỳ 9", icon: "star.fill")
    ]
}

struct SemesterChosenView: View {
    @ObservedObject var semesterData = SemesterData()
    @State private var activeSemester: UUID?

    var body: some View {
        VStack {
            HeaderCategoryView(textCategory: "Danh mục",
                               textButton: "Xem thêm",
                               action: {})

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(semesterData.semesters) { semester in
                        VStack {
                            Image(systemName: semester.icon)
                                .foregroundStyle(semester.id == activeSemester ? .white : .black)
                                .font(.system(size: 18))
                                .padding(16)
                                .background(semester.id == activeSemester ? Color.activeColor : .white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 0.5)
                                )
                                .onTapGesture {
                                    activeSemester = semester.id
                                }

                            Text(semester.name)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    SemesterChosenView()
}
