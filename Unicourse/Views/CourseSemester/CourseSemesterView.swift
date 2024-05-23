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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 5)], spacing: 10) {
                    if viewModel.listCourseSemester.isEmpty {
                        ForEach(0 ..< 6) { _ in
                            NavigationLink(destination: CourseDetailView(courseId: "65a8790ba30979a347d026c9")) {
                                SkeletonGridCourseView()
                            }
                        }
                    } else {
                        ForEach(viewModel.listCourseSemester, id: \._id) { course in
                            NavigationLink(destination: CourseDetailView(courseId: "65a8790ba30979a347d026c9")) {
                                SearchResultItemView(courseItem: course)
                            }
                        }
                    }
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
