//
//  CourseListView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 21/5/24.
//

import SwiftUI

struct CourseListView: View {
    let courseItem: EnrolledCourseModel
    var body: some View {
        HStack(spacing: 13.0) {
            VStack {
                VStack {
                    AsyncImage(url: URL(string: courseItem.course?.thumbnail ?? "")!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)

                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: UIScreen.main.bounds.width * 0.2, height: 64)
                            .shimmerWithWave()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.2, height: 64)
            .background(Color.mainColor1)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))

            VStack(alignment: .leading, spacing: 20) {
                Text(courseItem.course?.title ?? "")
                    .font(.system(size: 14, weight: .bold))

                HStack(alignment: .center) {
                    Text(formatDateToMonthDay(dateString: courseItem.enrollDate)!)
                    Text("-")
                    Text(formatDateToHourMinute(dateString: courseItem.enrollDate)!)
                    Text("-")

                    Text("\(courseItem.progress)%")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color(hex: "#4284F4"))
                }
                .font(.system(size: 12, weight: .light))
            }
            Spacer()
            Image(systemName: "chevron.forward")
                .padding(.trailing, 12)
        }
    }
}

// #Preview {
//    CourseListView(courseItem: EnrolledCourseModel.sampleData)
// }
