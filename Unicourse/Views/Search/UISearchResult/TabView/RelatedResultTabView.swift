//
//  RelatedResultTabView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct RelatedResultTabView: View {
    @Binding var isLoadingSearch: Bool
    @Binding var listSearch: SearchResponseModel
    @ObservedObject var viewModel: SearchEntryViewModel

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 30)], spacing: 20) {
                    if isLoadingSearch {
                        ForEach(0 ..< 6) { _ in
                            SkeletonGridCourseView()
                        }
                    } else {
                        if listSearch.course.isEmpty {
                            VStack(alignment: .center) {
                                Spacer()

                                NotFoundImageView(width: 420, height: 200)
                                Text("Không tìm thấy khoá học nào phù hợp !")

                                Spacer()
                            }
                        } else {
                            ForEach(listSearch.course.indices, id: \.self) { index in
                                let course = listSearch.course[index]
                                NavigationLink(destination: CourseDetailView(courseId: course._id)) {
                                    SearchResultItemView(title: course.title,
                                                         description: course.titleDescription,
                                                         thumbnail: course.thumbnail,
                                                         lectureName: course.lecture.fullName,
                                                         lectureImage: course.lecture.profile_image,
                                                         courseType: course.type,
                                                         courseAmount: course.amount)
                                }
                                .onAppear {
                                    // Load more content when the last item appears
                                    if index == listSearch.course.count - 1 {
                                        viewModel.loadMore(searchText: viewModel.searchString)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .background {
                Color.mainBackgroundColor
            }
            if viewModel.isLoadingMore {
                VStack {
                    JustLoadingView(isLoading: .constant(true))
                }
                .padding(.horizontal, 10)
            }
        }
        .onDisappear {
            SDImageCache.shared.clearMemory()
        }
    }
}

#Preview {
    RelatedResultTabView(isLoadingSearch: .constant(true), listSearch: .constant(.init(course: [], quiz: [], blog: [])), viewModel: SearchEntryViewModel())
}
