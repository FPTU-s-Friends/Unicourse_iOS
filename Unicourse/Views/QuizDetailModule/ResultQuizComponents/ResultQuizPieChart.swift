//
//  ResultQuizView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/6/24.
//

import Charts
import SwiftUI

struct StatusAnswer: Identifiable, Equatable {
    var category: String
    var amount: Double
    var id = UUID()
}

let statusAnswerData: [StatusAnswer] = [
    .init(category: "Chưa trả lời", amount: 10),
    .init(category: "Trả lời sai", amount: 10),
    .init(category: "Trả lời đúng", amount: 10),
]

struct ResultQuizPieChart: View {
    @State private var selectedAmount: Double? = nil
    let cumulativeIncomes: [(category: String, range: Range<Double>)]
    let percentage: Double
    @State private var statusAnswerData: [StatusAnswer]

    // Initializer to accept trueAnswer, falseAnswer, and undefinedAnswer
    init(trueAnswer: Double, falseAnswer: Double, undefinedAnswer: Double) {
        let initialData: [StatusAnswer] = [
            .init(category: "Chưa trả lời", amount: undefinedAnswer),
            .init(category: "Trả lời sai", amount: falseAnswer),
            .init(category: "Trả lời đúng", amount: trueAnswer),
        ]

        self.percentage = trueAnswer / (trueAnswer + falseAnswer + undefinedAnswer)
        var cumulative = 0.0
        self.cumulativeIncomes = initialData.map {
            let newCumulative = cumulative + $0.amount
            let result = (category: $0.category, range: cumulative ..< newCumulative)
            cumulative = newCumulative
            return result
        }

        _statusAnswerData = State(initialValue: initialData)
    }

    // Default initializer
    init() {
        let initialData: [StatusAnswer] = [
            .init(category: "Chưa trả lời", amount: 10),
            .init(category: "Trả lời sai", amount: 10),
            .init(category: "Trả lời đúng", amount: 10),
        ]

        var cumulative = 0.0
        self.cumulativeIncomes = initialData.map {
            let newCumulative = cumulative + $0.amount
            let result = (category: $0.category, range: cumulative ..< newCumulative)
            cumulative = newCumulative
            return result
        }

        _statusAnswerData = State(initialValue: initialData)
        self.percentage = 2
    }

    var selectedCategory: StatusAnswer? {
        if let selectedAmount,
           let selectedIndex = cumulativeIncomes
           .firstIndex(where: { $0.range.contains(selectedAmount) })
        {
            return statusAnswerData[selectedIndex]
        }
        return nil
    }

    var body: some View {
        VStack {
            Chart(statusAnswerData) {
                SectorMark(
                    angle: .value("Amount", $0.amount),
                    innerRadius: .ratio(selectedCategory == $0 ? 0.5 : 0.6),
                    outerRadius: .ratio(selectedCategory == $0 ? 1.0 : 0.9),
                    angularInset: 3.0
                )
                .cornerRadius(6.0)
                .foregroundStyle(by: .value("category", $0.category))
                .opacity(selectedCategory == $0 ? 1.0 : 0.9)
            }
            // Set color for each data in the chart
            .chartForegroundStyleScale(
                domain: statusAnswerData.map(\.category),
                range: [
                    Color.undefinedAnswer,
                    Color.falseAnswer,
                    Color.trueAnswer,
                ]
            )
            // Position the Legend
            .chartLegend(position: .trailing, alignment: .center)

            // Select a sector
            .chartAngleSelection(value: $selectedAmount)

            // Display data for selected sector
            .chartBackground { chartProxy in
                GeometryReader { geometry in
                    let frame = geometry[chartProxy.plotFrame!]
                    VStack(spacing: 0) {
                        Text(selectedCategory?.category ?? "Điểm của bạn")
                            .multilineTextAlignment(.center)
                            .font(.body)
                            .foregroundStyle(.secondary)

                        selectedCategory?.amount != nil ? Text("\(formatValue(selectedCategory?.amount ?? 30))")
                            .font(.title.bold())
                            .foregroundColor((selectedCategory != nil) ? .primary : .clear)
                            :
                            Text("\(convertToPercentage(percentage))%")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
            }
            .frame(height: 300)
        }
        .padding()
    }

    func convertToPercentage(_ value: Double) -> Int {
        Int(value * 100)
    }

    func formatValue(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            String(format: "%.0f", value)
        } else {
            String(format: "%.1f", value)
        }
    }
}

#Preview {
    ResultQuizPieChart()
}
