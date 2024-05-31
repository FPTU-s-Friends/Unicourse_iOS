//
//  SuggessCourseView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 10/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct SuggestCourseView: View {
    @Binding var listSearch: SearchResponseModel
    @Binding var isLoadingSearch: Bool

    var body: some View {
        HStack {
            Text("Suggest Courses")
                .font(.system(size: 12))
                .lineSpacing(20)
                .foregroundColor(Color(red: 0.55, green: 0.54, blue: 0.54))

            Spacer()

            Button(action: {}, label: {
                Image("reloadIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
            })
        }
        .padding(.horizontal, 10)

        if isLoadingSearch {
            VStack {
                ScrollView {
                    ForEach(0 ..< 12) { _ in
                        SkeletonSuggestCourse()
                    }
                }
            }
        } else {
            VStack {
                //                LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 20)], spacing: 60) {
                ForEach(listSearch.course, id: \._id) { course in
                    NavigationLink(destination: CourseDetailView(courseId: course._id)) {
                        SuggestCourseItem(course: course)
                    }
                    .cornerRadius(10)
                }
                //            }
            }
        }
    }
}

struct SuggestCourseItem: View {
    var course: SearchCourseModel

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

                Text(course.titleDescription)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 10)
                    .lineLimit(1)

                if course.type == .fee {
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
            .frame(maxWidth: 220, alignment: .leading)
        }
    }
}

#Preview {
    NavigationStack {
        SuggestCourseView(listSearch: .constant(.init(course: [SearchCourseModel.sampleData], quiz: [], blog: [])), isLoadingSearch: .constant(false))
    }
}
