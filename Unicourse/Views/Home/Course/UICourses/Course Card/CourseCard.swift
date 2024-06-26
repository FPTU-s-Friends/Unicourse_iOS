//
//  CourseCard.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 8/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct CourseCard: View {
    @EnvironmentObject var appData: AppData
    private let totalPercentageProcess: Double = 100
    let courseItem: EnrolledCourseModel

    var listTrack: [Track] {
        courseItem.trackProgress?.map { item in
            item.track!
        } ?? []
    }

    var body: some View {
        VStack(spacing: 13) {
            HStack(alignment: .top, spacing: 10) {
                VStack {
                    WebImage(url: URL(string: courseItem.course?.lecture?.profile_image ?? "")!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 28, height: 28)
                            .cornerRadius(20)

                    } placeholder: {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 28, height: 28)
                            .cornerRadius(20)
                    }
                }

//                Circle()
//                    .frame(width: 32, height: 32)
//                    .foregroundStyle(.green.gradient)
                Text(courseItem.course?.title ?? "")
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

                // If this course same id with enrolled course => navigate to streaming video

                NavigationLink(destination:
                    CourseVideoPlayerView(listTrack: listTrack, title: courseItem.course?.subTitle ?? "")
                        .navigationBarBackButtonHidden(true),
                    label: {
                        Text("Tiếp tục")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(width: 100, height: 30)
                            .background(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom))
                            .clipShape(RoundedRectangle(cornerRadius: 7.0))
                    })

                // End: If this course same id with enrolled course => navigate to streaming video
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
    CourseCard(courseItem: EnrolledCourseModel(_id: "", user: BasicUserInfo(_id: "", email: "", fullName: "", profileName: "", profile_image: ""), course: CourseModel.sampleData, completed: true, enrollDate: "", progress: 10, trackProgress: []))
}
