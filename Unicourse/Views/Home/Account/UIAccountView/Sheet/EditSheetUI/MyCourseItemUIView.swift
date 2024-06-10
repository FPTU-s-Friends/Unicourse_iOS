//
//  MyCourseItemUIView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 9/6/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct MyCourseItemUIView: View {
    var course: EnrollCourseUserInfo

    var body: some View {
        HStack(spacing: 4) {
            WebImage(url: URL(string: course.courseId.thumbnail)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.4, height: 80)
                    .padding(.trailing, 10)
                    .cornerRadius(10)

            } placeholder: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 140, height: 80)
                    .padding(.trailing, 10)
                    .shimmerWithWave()
            }

            VStack(alignment: .leading) {
                Text(course.courseId.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 10)

                Text(course.courseId.lecture.fullName)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 10)
                    .lineLimit(1)
            }
            .frame(maxWidth: 220, alignment: .leading)
        }
    }
}

#Preview {
    MyCourseItemUIView(course: .sampleData)
}
