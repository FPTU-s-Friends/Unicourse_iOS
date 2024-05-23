//
//  TrackingCourseCard.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

struct TrackingCourseCard: View {
    var enrollCourse: EnrolledCourseModel

    var body: some View {
        VStack(spacing: 11) {
            HStack(alignment: .top, spacing: 12) {
                VStack {
                    VStack {
                        AsyncImage(url: URL(string: enrollCourse.course.thumbnail)!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 65, height: 65)

                        } placeholder: {
                            Image(._3Dicons)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                }
                .padding(5)
                .background(Color(hex: "#FBCCCE"))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                VStack(alignment: .leading, spacing: 5) {
                    Text("Tuần 2")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.mainColor2)

                    HStack(alignment: .center, spacing: 12) {
                        // Icon Tracking Course
                        ZStack {
                            Image(.trackingCourseLine)
                            Image(.trackingCourseCircle)
                        }
                        // End Icon Tracking Course
                        Text(enrollCourse.course.titleDescription)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .font(.system(size: 14, weight: .medium))
                            .frame(width: 212, height: 40)
                    }
                }
                Spacer()
            }

            HStack {
                Group {
                    AsyncImage(url: URL(string: enrollCourse.user.profile_image)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .cornerRadius(20)

                    } placeholder: {
                        ProgressView()
                    }

                    Text(enrollCourse.user.fullName)
                        .font(.system(size: 12))
                        .foregroundColor(.mainColor2)
                }
                Spacer()
                Group {
                    VStack {
                        Image(systemName: "square.stack.3d.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                    }
                    .padding(6)
                    .background(Color(hex: "#DDE0FF"))
                    .clipShape(RoundedRectangle(cornerRadius: 7.0))

                    // Button
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
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: 133)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
}

#Preview {
    TrackingCourseCard(enrollCourse: EnrolledCourseModel(_id: "", user: BasicUserInfo(_id: "", email: "", fullName: "", profileName: "", profile_image: ""), course: CourseInEnrolledCoursesModel(_id: "", type: .free, titleDescription: "", title: "", thumbnail: "", subTitleDescription: [""], subTitle: "", enrollmentCount: 9), completed: false, enrollDate: "", progress: 76, trackProgress: [Track(_id: "", trackId: TrackId(_id: "", position: 9, chapterTitle: "", track_steps: [TrackStep(_id: "", title: "", position: 9, duration: 9, content_url: "", type: "")]), completed: false)]))
}
