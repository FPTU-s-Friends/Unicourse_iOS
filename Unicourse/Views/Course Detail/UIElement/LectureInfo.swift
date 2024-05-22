//
//  LectureInfo.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/5/24.
//

import SwiftUI

struct LectureInfo: View {
    let courseAuthorName: String
    let courseRatingPoint: Double
    let totalCourseOfAuthor: Int
    let courseAuthorBio: String
    let imageLectureURL: String
    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Group {
                    AsyncImage(url: URL(string: imageLectureURL)!) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    } placeholder: {
                        ProgressView()
                    }

                    VStack(alignment: .leading) {
                        Text(courseAuthorName)
                            .font(.system(size: 14, weight: .bold))
                        HStack {
                            RatingStars(rating: courseRatingPoint)
                            Text("\(totalCourseOfAuthor) khoá học")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.neutralTextColor)
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    }
                }
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/, label: {
                    Text("Xem thông tin")
                        .frame(height: 20)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .font(.system(size: 12, weight: .medium))
                        .background(Color(hex: "#4284F4"))
                        .cornerRadius(7.0)

                })
                .tint(.white)
            }

            VStack {
                Text(courseAuthorBio)
                    .font(.system(size: 14, weight: .medium))
            }
            .padding(12)
            .frame(width: 295)
            .background(Color(hex: "#F7F8FC"))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 0.2)
            )
            .cornerRadius(16.0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 17)
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 0.1)
        )
        .cornerRadius(16)
    }
}

//
// #Preview {
//    LectureInfo(courseAuthorName: "Nguyễn Trung Kiên", courseRatingPoint: 3.5, totalCourseOfAuthor: 11, courseAuthorBio: "Thiết kế không chỉ là trông nó như thế nào và cảm thấy như thế nào. Thiết kế là cách nó hoạt động")
// }
