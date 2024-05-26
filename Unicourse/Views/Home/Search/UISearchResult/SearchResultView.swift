//
//  SearchResultView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 10/5/24.
//

import SwiftUI

struct SearchResultView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var searchString: String
    @Binding var isLoadingSearch: Bool
    @Binding var listSearch: SearchResponseModel
    @State var activeTab = "Liên quan"

    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea(.all)

            VStack {
                ResultUserView()

                HStack {
                    TabButton(title: "Liên quan", isActive: activeTab == "Liên quan") {
                        activeTab = "Liên quan"
                    }

                    Spacer()

                    TabButton(title: "Mới nhất", isActive: activeTab == "Mới nhất") {
                        activeTab = "Mới nhất"
                    }

                    Spacer()

                    TabButton(title: "Giảm giá", isActive: activeTab == "Giảm giá") {
                        activeTab = "Giảm giá"
                    }
                }
                .padding(20)

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
        .searchable(text: $searchString, prompt: Text("Tìm Khoá Học"))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                })
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    HStack(spacing: 8) {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                    }
                    .padding(8)
                    .background(.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .inset(by: 0.25)
                            .stroke(Color(red: 0.26, green: 0.52, blue: 0.96), lineWidth: 0.25)
                    )
                })
            }
        }
    }
}

#Preview {
    SearchResultView(searchString: .constant(""), isLoadingSearch: .constant(true), listSearch: .constant(.init(course: [], quiz: [], blog: [])))
}
