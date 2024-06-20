import Charts
import SwiftUI

struct StatusAnswers: Identifiable {
    var id = UUID()
    var category: String
    var amount: Double
}

struct AnimatedPieChart: Shape {
    var data: [StatusAnswers]
    var progress: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var startAngle = Angle(degrees: -90)

        for item in data {
            let angle = Angle(degrees: 360 * (item.amount / totalAmount) * Double(progress))
            let endAngle = startAngle + angle

            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            path.addLine(to: center)
            path.closeSubpath()

            startAngle = endAngle
        }

        return path
    }

    var totalAmount: Double {
        data.reduce(0) { $0 + $1.amount }
    }
}

struct ContentViews: View {
    @State private var statusAnswerData: [StatusAnswers] = [
        StatusAnswers(category: "Undefined", amount: 10),
        StatusAnswers(category: "False", amount: 20),
        StatusAnswers(category: "True", amount: 30)
    ]
    @State private var selectedCategory: StatusAnswers? = nil
    @State private var animationProgress: CGFloat = 0

    var body: some View {
        VStack {
            AnimatedPieChart(data: statusAnswerData, progress: animationProgress)
                .fill(Color.blue) // You can adjust color accordingly
                .frame(width: 300, height: 300)
                .onAppear {
                    withAnimation(.easeOut(duration: 1.5)) {
                        animationProgress = 1.0
                    }
                }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentViews()
}
