//
//  CourseCard.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 8/5/24.
//

import SwiftUI

struct CourseCard: View {
    private let totalPercentageProces: Double = 100
    let courseName: String
    let courseChapter: Int
    let coursePercentageProcess: Int
    let courseButtonTitle: String
    let action: () -> Void

    var body: some View {
        VStack(spacing: 13) {
            HStack(alignment: .top, spacing: 10) {
                Circle()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.green.gradient)
                Text(courseName)
                    .font(.system(size: 14, weight: .bold))
                Spacer()
            }

            HStack(spacing: 14) {
                CustomProgressView(value: Double(coursePercentageProcess), total: totalPercentageProces)
                Text("\(coursePercentageProcess)%")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 9)
                    .background(Color(hex: "#16AEF4"))
                    .clipShape(Capsule())
            }
            Divider()
            HStack {
                Group {
                    Image(systemName: "square.stack.3d.up")
                    Text("Chương \(courseChapter)")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(hex: "#8D8A8A"))
                }
                Spacer()
                NavigationLink(destination:
                    CourseDetailView()
                        .navigationBarBackButtonHidden(true),

                    label: {
                        Text("Tiếp tục")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(width: 100, height: 30)
                            .background(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom))
                            .clipShape(RoundedRectangle(cornerRadius: 7.0))
                    })
            }
        }
        .padding(14)
        .frame(width: 258, height: 160)
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 0.1)
        )
        .cornerRadius(16)
        // End Card Course
    }
}

#Preview {
    CourseCard(courseName: "Khoá học NextJS", courseChapter: 10, coursePercentageProcess: 22, courseButtonTitle: "Tiếp tục", action: {})
}
