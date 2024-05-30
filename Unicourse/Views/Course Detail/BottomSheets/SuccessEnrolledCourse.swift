//
//  SuccessEnrolledCourse.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 30/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct SuccessEnrolledCourse: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToCourseView = false
    var courseReponse: EnrolledNewCourseModel
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Group {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(.green)

                        Text("Thành công !")
                            .font(.title)
                            .bold()
                    }
                    Text("Bạn đã đăng ký thành công khoá học")
                    Text(courseReponse.course.title)
                        .bold()
                }

                HStack(spacing: 4) {
                    WebImage(url: URL(string: courseReponse.course.thumbnail ?? "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Course%2FCN8%2FPRM392.png?alt=media&token=a2164ded-1dc9-47c6-b952-b499872868b4")) { image in
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
                        Text(courseReponse.course.title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 10)

                        Text(formatDateToMonthDay(dateString: courseReponse.enrollDate) ?? "")
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(.horizontal, 10)
                            .lineLimit(1)

                        if true {
                            Text("Paid Course")
                                .font(.caption)
                                .foregroundStyle(Color.activeButtonColor)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 10)
                        } else {
                            Text("Free")
                                .font(.caption)
                                .foregroundStyle(Color.green)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 10)
                        }
                    }
                    .frame(width: 200, alignment: .leading)
                }
                .padding([.top, .bottom], 20)

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        navigateToCourseView = true
                    }
                }) {
                    ButtonGradientUI(titleButton: "Khoá học của tôi")
                        .padding(20)
                }
            }
            .background(
                NavigationLink(destination: CourseView(), isActive: $navigateToCourseView) {
                    EmptyView()
                }
            )
        }
    }
}

#Preview {
    NavigationStack {
        SuccessEnrolledCourse(courseReponse: EnrolledNewCourseModel(_id: "", user: EnrolledNewCourseModelUser(_id: "", email: ""), course: EnrolledNewCourseModelCourse(_id: "", title: "", titleDescription: "", subTitle: "", subTitleDescription: [], thumbnail: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Course%2FCN8%2FPRM392.png?alt=media&token=a2164ded-1dc9-47c6-b952-b499872868b4"), progress: 2, enrollDate: "", completed: true, trackProgress: []))
    }
}
