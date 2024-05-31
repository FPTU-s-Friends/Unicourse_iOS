//
//  MyCourseLectureItem.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 31/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct MyCourseLectureItem: View {
    var course: My_Course_Detail
    var lecture_name: String

    var body: some View {
        HStack(spacing: 4) {
            WebImage(url: URL(string: course.thumbnail)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 80)
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
                Text(course.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 10)

                Text(lecture_name)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 10)
                    .lineLimit(1)
            }
            .frame(maxWidth: 220, alignment: .leading)
        }
    }
}

//
// #Preview {
//    MyCourseLectureItem()
// }
