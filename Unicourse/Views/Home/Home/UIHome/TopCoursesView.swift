//
//  TopCoursesView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct TopCoursesView: View {
    var freeCourses: [CourseModel]
    @Binding var isLoadingFreeCourse: Bool

    var body: some View {
        HeaderCategoryView(textCategory: HeaderCategoryText.topCourseText,
                           textButton: TextButton.viewMore,
                           action: {})

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if self.isLoadingFreeCourse || self.freeCourses.isEmpty {
                    ForEach(0 ..< 3) { _ in
                        SkeletonCourseProgressCard()
                    }
                } else {
                    ForEach(freeCourses, id: \._id) { course in
                        NavigationLink(destination: CourseDetailView(courseDetail: course)) {
                            ZStack {
                                ZStack(alignment: .topTrailing) {
                                    AsyncImage(url: URL(string: course.thumbnail)!) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                        
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                    VStack {
                                        Text("Now")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(.white)
                                            .padding(5)
                                            .padding(.horizontal, 10)
                                            .background(Color.activeColor.cornerRadius(10))
                                    }
                                    .padding(.top, 10)
                                    .padding(.trailing, 10)
                                }
                                
                                VStack(alignment: .leading) {
                                    Spacer()
                                    HStack {
                                        Image(.user)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20)
                                        
                                        Text(course.lecture?.fullName ?? "Bố mày")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundStyle(.black)
                                            .padding(6)
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(10)
                                        
                                        Spacer()
                                        
                                        Text("01:42:56")
                                            .font(.system(size: 10, weight: .light))
                                            .foregroundStyle(.black)
                                            .padding(6)
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(10)
                                    }
                                    
                                    Text(course.title)
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                }
                                .padding(10)
                            }
                            .frame(width: 270)
                            .cornerRadius(20)
                            .padding(.leading, 10)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TopCoursesView(freeCourses: [], isLoadingFreeCourse: .constant(true))
}
