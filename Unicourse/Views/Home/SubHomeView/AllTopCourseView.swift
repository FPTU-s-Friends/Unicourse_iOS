//
//  AllTopCourseView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 29/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct AllTopCourseView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 20)], spacing: 10) {
                    ForEach(searchCourses, id: \._id) { course in
                        NavigationLink(destination: CourseDetailView(courseId: course._id)) {
                            ZStack {
                                VStack {
                                    AsyncImage(url: URL(string: course.thumbnail)!) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 150)
                                            .cornerRadius(20)

                                    } placeholder: {
                                        ProgressView()
                                    }

                                    VStack(alignment: .leading) {
                                        VStack {
                                            Text(course.title)
                                                .font(.system(size: 14, weight: .semibold))
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(2)
                                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                                .padding(5)
                                        }

                                        HStack(alignment: .top, spacing: 0) {
                                            Image(.user)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 24)

                                            VStack(alignment: .leading) {
                                                Text(course.lecture.fullName)
                                                    .font(.system(size: 12, weight: .bold))
                                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                                    .multilineTextAlignment(.leading)
                                                    .lineLimit(1)
                                                    .padding(5)
                                                    .background(.ultraThickMaterial)
                                                    .cornerRadius(10)
                                            }

                                            Spacer()

                                            Text("\(course.type == .free ? "Free" : "Paid")")
                                                .font(.system(size: 12, weight: .semibold))
                                                .foregroundStyle(course.type == CourseEnrollType.free ? Color.green.gradient : Color.blue.gradient)
                                                .padding(5)
                                                .padding(.horizontal, 10)
                                                .background(.ultraThinMaterial)
                                                .cornerRadius(10)
                                        }

                                        VStack {
                                            if course.type == .free {
                                                Text("\(course.amount + 40000) đ")
                                                    .font(.system(size: 14, weight: .bold))
                                                    .strikethrough()
                                                    .lineSpacing(20)
                                                    .foregroundColor(.mainColor1)

                                            } else {
                                                HStack(alignment: .firstTextBaseline, spacing: 4) {
                                                    Text("\(course.amount) đ")
                                                        .font(.system(size: 14, weight: .bold))
                                                        .lineSpacing(20)
                                                        .foregroundColor(.mainColor1)
                                                    Text("\(course.amount + 20000) đ")
                                                        .font(.system(size: 12))
                                                        .lineSpacing(20)
                                                        .strikethrough()
                                                        .foregroundColor(.gray)
                                                }
                                                .padding(.horizontal, 15)
                                                .padding(.bottom, 10)
                                            }
                                        }
                                        .padding(.horizontal, 5)
                                    }
                                    .padding(.horizontal, 10)
                                }

                                VStack {
                                    Text("New")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                                        .padding(5)
                                        .padding(.horizontal, 10)
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(20)
                                        .offset(x: 95, y: -100)
                                }
                            }
                            .frame(width: 270, height: 260)
                            .background(colorScheme == .dark ? .black : .white)
                            .cornerRadius(20)
                        }
                    }
                }
                .padding()
            }
            .background {
                Color.mainBackgroundColor
            }
//            if viewModel.isLoadingMore {
//                ProgressView()
//                    .frame(maxWidth: .infinity, alignment: .center)
//            }
        }
        .onDisappear {
            SDImageCache.shared.clearMemory()
        }
    }
}

#Preview {
    AllTopCourseView()
}
