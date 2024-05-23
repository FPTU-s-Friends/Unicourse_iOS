//
//  CourseCard.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 8/5/24.
//

import SwiftUI

struct CourseCard: View {
    private let totalPercentageProcess: Double = 100
    let courseItem: EnrolledCourseModel

    var body: some View {
        VStack(spacing: 13) {
            HStack(alignment: .top, spacing: 10) {
                VStack {
                    // chỗ này để mốt sửa thành lecture image vào
                    AsyncImage(url: URL(string: courseItem.user.profile_image)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 28, height: 28)
                            .cornerRadius(20)

                    } placeholder: {
                        Image("person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 28, height: 28)
                            .cornerRadius(20)
                    }
                }

//                Circle()
//                    .frame(width: 32, height: 32)
//                    .foregroundStyle(.green.gradient)
                Text(courseItem.course.title)
                    .font(.system(size: 14, weight: .bold))
                Spacer()
            }

            HStack(spacing: 14) {
                CustomProgressView(value: Double(courseItem.progress), total: totalPercentageProcess)
                Text("\(courseItem.progress)%")
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
                    Text(courseItem.completed ? "Đã hoàn thành" : "Chưa hoàn thành")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(hex: "#8D8A8A"))
                }
                Spacer()
                NavigationLink(destination:
                    CourseDetailView(courseId: "65a8790ba30979a347d026c9")
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
        .clipShape(RoundedRectangle(cornerRadius: 16))

        // End Card Course
    }
}

#Preview {
    CourseCard(courseItem: EnrolledCourseModel(_id: "", user: BasicUserInfo(_id: "", email: "", fullName: "", profileName: "", profile_image: ""), course: CourseInEnrolledCoursesModel(_id: "", type: .fee, titleDescription: "", title: "", thumbnail: "", subTitleDescription: [""], subTitle: "", semester_number: 9, enrollmentCount: 9), completed: true, enrollDate: "", progress: 10, trackProgress: []))
}
