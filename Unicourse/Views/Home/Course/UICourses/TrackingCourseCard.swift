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
                        if let urlString = enrollCourse.course?.thumbnail, let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width * 0.2, height: 65)
                            } placeholder: {
                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width * 0.2, height: 65)
                                    .shimmerWithWave()
                            }
                        } else {
                            Image("3Dicons")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.2, height: 65)
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
                            Image("tracking_course_line")
                            Image("tracking_course_circle")
                        }
                        // End Icon Tracking Course
                        if let titleDescription = enrollCourse.course?.titleDescription {
                            Text(titleDescription)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .font(.system(size: 14, weight: .medium))
                                .frame(width: 212, height: 40)
                        }
                    }
                }
                Spacer()
            }

            HStack {
                Group {
                    if let profileImageURL = URL(string: enrollCourse.user.profile_image) {
                        AsyncImage(url: profileImageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .cornerRadius(20)
                        } placeholder: {
                            Rectangle()
                                .frame(width: 24, height: 24)
                                .cornerRadius(20)
                                .shimmerWithWave()
                        }
                    } else {
                        Rectangle()
                            .frame(width: 24, height: 24)
                            .cornerRadius(20)
                            .shimmerWithWave()
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
                    if let course = enrollCourse.course {
                        NavigationLink(destination:
                            CourseDetailView(courseId: course._id)
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
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: 133)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
}

//
//// Sample Preview
// struct TrackingCourseCard_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackingCourseCard(enrollCourse: EnrolledCourseModel.sampleData)
//    }
// }
