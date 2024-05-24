//
//  CurrentLearningCourses.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

struct CurrentLearningCourses: View {
    @Binding var showingCredits: Bool
    var listEnrolledCourses: [EnrolledCourseModel]
    var isLoadSkeleton: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Title
                PathTitle(title: "Đang học", isHaveButton: true,
                          actionButton: { showingCredits.toggle() })
                    .padding(.trailing, 28)
                    .sheet(isPresented: $showingCredits) {
                        AllCourseView()
                            .presentationDetents([.medium])
                    }

                if listEnrolledCourses.isEmpty, isLoadSkeleton == true {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0 ..< 2) { _ in
                                SkeletonCourseProgressCard()
                            }
                        }
                    }
                } else if listEnrolledCourses.isEmpty, isLoadSkeleton == false {
                    NotfoundMyCourseView()
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(listEnrolledCourses, id: \._id) { courseItem in
                                CourseCard(courseItem: courseItem)
                            }
                        }
                    }
                }

                // End List card
            }
            .padding(.leading, 8)
            .padding(.bottom, 15)

            // End Current learning  course
            VStack(spacing: 10) {
                PathTitle(title: "Tất cả khoá học", isHaveButton: false, actionButton: {})
                    .padding(.trailing, 28)

                HStack(spacing: 4) {
                    Text("Tất cả")
                        .font(.system(size: 12))
                        .padding(5)
                        .padding(.horizontal, 10)
                        .foregroundStyle(.white)
                        .background(Color(hex: "#16AEF4"))
                        .cornerRadius(16)
                    Text("Đang học")
                        .font(.system(size: 12))
                        .padding(5)
                        .padding(.horizontal, 10)
                        .cornerRadius(16)
                    Text("Đã hoàn thành")
                        .font(.system(size: 12))
                        .padding(5)
                        .padding(.horizontal, 10)
                        .cornerRadius(16)
                    Spacer()
                }

                LazyVStack {
                    if listEnrolledCourses.isEmpty, isLoadSkeleton == true {
                        ForEach(0 ..< 2) { _ in
                            SkeletonCourseListView()
                        }
                    } else if listEnrolledCourses.isEmpty, isLoadSkeleton == false {
                        NotfoundMyCourseView()
                    } else {
                        ForEach(listEnrolledCourses, id: \._id) {
                            courseItem in
                            NavigationLink(destination: CourseDetailView(courseDetail: courseItem.course ?? CourseModel.sampleData)) {
                                CourseListView(courseItem: courseItem)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }

                }.padding(.bottom, 100)

            }.padding(.leading, 12)
        }
    }
}

@ViewBuilder
func AllCourseView() -> some View {
    Text("All courses appears here")
}

#Preview {
    CurrentLearningCourses(showingCredits: .constant(false),
                           listEnrolledCourses: [EnrolledCourseModel.sampleData], isLoadSkeleton: true)
}
