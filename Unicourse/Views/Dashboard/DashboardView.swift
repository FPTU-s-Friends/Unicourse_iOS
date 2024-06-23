//
//  DashboardView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/6/24.
//
import Charts
import SwiftUI

struct CourseStat: Identifiable {
    let id = UUID()
    let date: Date
    let hours: Double
    let course: String
}

enum TimeFrame: String, CaseIterable {
    case daily
    case weekly
    case monthly
}

struct DashboardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()
    @State private var timeFrame: TimeFrame = .weekly
    @State private var courseData = [
        CourseStat(date: Date().addingTimeInterval(-86400 * 6), hours: 2, course: "Blender"),
        CourseStat(date: Date().addingTimeInterval(-86400 * 5), hours: 3, course: "Blender"),
        CourseStat(date: Date().addingTimeInterval(-86400 * 4), hours: 4, course: "Blender"),
        CourseStat(date: Date().addingTimeInterval(-86400 * 3), hours: 5, course: "Minecraft"),
        CourseStat(date: Date().addingTimeInterval(-86400 * 2), hours: 6, course: "Figma"),
        CourseStat(date: Date().addingTimeInterval(-86400), hours: 3, course: "Minecraft"),
        CourseStat(date: Date(), hours: 7, course: "Figma")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // Tiêu đề và tổng giờ học
                    HStack {
                        Text("25 hours")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        Picker("Time Frame", selection: $timeFrame) {
                            ForEach(TimeFrame.allCases, id: \.self) { frame in
                                Text(frame.rawValue.capitalized).tag(frame)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.trailing)
                    }
                    .padding(.horizontal)

                    Text("02 Mar – 09 Mar")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)

                    // Biểu đồ
                    Chart {
                        ForEach(courseData) { stat in
                            AreaMark(
                                x: .value("Date", stat.date),
                                y: .value("Hours", stat.hours)
                            )
                            .foregroundStyle(by: .value("Course", stat.course))
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .automatic(desiredCount: 7)) {
                            AxisValueLabel(format: .dateTime.day())
                        }
                    }
                    .frame(height: 250)
                    .padding(.horizontal)

                    // Chi tiết học
                    VStack(alignment: .leading) {
                        Text("Saturday, 08 Mar")
                            .font(.headline)
                        Text("4 hours of learning")
                            .font(.subheadline)
                            .padding(.bottom, 4)

                        ForEach(courseData.prefix(3), id: \.id) { stat in
                            HStack {
                                Text(stat.course)
                                    .font(.headline)
                                    .padding(.leading, 8)
                                Spacer()
                                Text("\(stat.hours / 25 * 100, specifier: "%.2f")%")
                                    .padding(.trailing, 8)
                            }
                            .padding(.vertical, 4)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .navigationTitle("Analysis 📊")
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        ButtonCircleUIView(systemName: "arrow.left.circle.fill") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

// Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
