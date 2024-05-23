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
    let color: Color

    static var listSemesters: [Semester] = [
        Semester(name: "Kỳ 1", icon: "book.fill", color: .red),
        Semester(name: "Kỳ 2", icon: "calendar", color: .blue),
        Semester(name: "Kỳ 3", icon: "graduationcap.fill", color: .green),
        Semester(name: "Kỳ 4", icon: "lightbulb.fill", color: .yellow),
        Semester(name: "Kỳ 5", icon: "brain.head.profile.fill", color: .purple),
        Semester(name: "Kỳ 6", icon: "rectangle.3.offgrid.bubble.left.fill", color: .orange),
        Semester(name: "Kỳ 7", icon: "chart.bar.fill", color: .pink),
        Semester(name: "Kỳ 8", icon: "pencil.tip.crop.circle.fill", color: .teal),
        Semester(name: "Kỳ 9", icon: "star.fill", color: .brown)
    ]
}

struct SemesterChosenView: View {
    var semesterData = Semester.listSemesters
    @State private var activeSemester: UUID?
    @State private var selectedSemesterIndex: Int?

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Danh Mục")
                        .font(.system(size: CGFloat.mainTitlePath, weight: .bold))
                    Rectangle()
                        .fill(Color.activeColor)
                        .frame(width: 60, height: 5)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding(.horizontal, 15)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(semesterData.enumerated()), id: \.element.id) { index, semester in
                        NavigationLink(destination: CourseSemesterView(semester: index + 1), tag: index, selection: $selectedSemesterIndex) {
                            EmptyView()
                        }
                        VStack {
                            Image(systemName: semester.icon)
                                .foregroundStyle(semester.id == activeSemester ? .white : semester.color)
                                .font(.system(size: 18))
                                .padding(16)
                                .background(semester.id == activeSemester ? Color.activeColor : Color.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 0.1)
                                )
                                .onTapGesture {
                                    activeSemester = semester.id
                                    selectedSemesterIndex = index
                                }

                            Text(semester.name)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(semester.id == activeSemester ? .black : .primary)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SemesterChosenView()
    }
}
