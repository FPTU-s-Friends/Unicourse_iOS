//
//  RelatedResultTabView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import SwiftUI

struct RelatedResultTabView: View {
    @Binding var isLoadingSearch: Bool
    @Binding var listSearch: SearchResponseModel

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 5)], spacing: 10) {
                    if isLoadingSearch {
                        ForEach(0 ..< 6) { _ in
                            SkeletonGridCourseView()
                        }
                    } else {
                        ForEach(listSearch.course, id: \._id) { course in
                            NavigationLink(destination: CourseDetailView(courseId: course._id)) {
                                SearchResultItemView(title: course.title, description: course.titleDescription, thumbnail: course.thumbnail)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RelatedResultTabView(isLoadingSearch: .constant(true), listSearch: .constant(.init(course: [], quiz: [], blog: [])))
}
