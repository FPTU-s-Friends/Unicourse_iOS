//
//  CourseSemesterView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

struct CourseSemesterView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @EnvironmentObject var appData: AppData
    @StateObject var viewModel = CourseSemesterViewModel()
    var semester: Int

    var body: some View {
        VStack {
            ScrollView {
                if viewModel.isLoading {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 5)], spacing: 10) {
                        ForEach(0 ..< 6) { _ in
                            SkeletonGridCourseView()
                        }
                    }
                } else if viewModel.isLoading == false && !viewModel.listCourseSemester.isEmpty {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 5)], spacing: 10) {
                        ForEach(viewModel.listCourseSemester, id: \._id) { course in
                            NavigationLink(destination: CourseDetailView(courseId: course._id)) {
                                SearchResultItemView(title: course.title,
                                                     description: course.titleDescription,
                                                     thumbnail: course.thumbnail,
                                                     lectureName: course.lecture?.fullName ?? DefaultTextUser.defaultNameLecture,
                                                     lectureImage: course.lecture?.profile_image ?? DefaultURL.defaultUserURL,
                                                     courseType: course.type,
                                                     courseAmount: course.amount ?? 0)
                            }
                        }
                    }
                } else {
                    NotfoundView(systemName: "shippingbox.fill", message: "Chưa có khoá học cho kì \(semester)")
                }
            }
        }
        .onAppear {
            viewModel.getCourseSemester(semester: semester, token: appData.token)
        }
        .background(Color.mainBackgroundColor)
        .navigationBarTitle("Khoá học kì \(semester)", displayMode: .large)
        .navigationBarBackButtonHidden(true)
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
                Button(action: {
                    viewModel.isSheetPresented = true
                }, label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                })
            }
        }
        .popover(isPresented: $viewModel.isSheetPresented) {
            Text("Chọn lọc cho phần chuyên ngành ở đây")
        }
        .searchable(text: $viewModel.searchString, prompt: Text("Tìm kiếm"))
    }
}

#Preview {
    NavigationStack {
        CourseSemesterView(semester: 9)
    }
}
