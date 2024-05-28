//
//  SemesterChoosenView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct SemesterChosenView: View {
    @State private var activeSemester: UUID?
    @State private var selectedSemesterIndex: Int?
    var semesterData = SemesterModel.listSemesters

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(HeaderCategoryText.headerSemesterText)
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
            }
        }
    }
}

#Preview {
    NavigationStack {
        SemesterChosenView()
            .environmentObject(AppData())
    }
}
