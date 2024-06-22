//
//  CourseSemesterView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

struct CourseSemesterView: View {
    @EnvironmentObject var appData: AppData
    @StateObject var viewModel = CourseSemesterViewModel()
    @State private var filterCategoryMajor = 0
    var semester: Int

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width * 0.45), spacing: 5)]) {
                        ForEach(0 ..< 6) { _ in
                            SkeletonGridCourseView()
                        }
                    }
                }
            } else if viewModel.isLoading == false && !viewModel.filteredCourseSemester.isEmpty {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width * 0.45), spacing: 5)]) {
                        ForEach(viewModel.filteredCourseSemester, id: \._id) { course in
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
                }
                .searchable(text: $viewModel.searchString, prompt: Text("Tìm kiếm"))

            } else {
                NotfoundView(systemName: "shippingbox.fill", message: "Chưa có khoá học cho kì \(semester)")
                Spacer()
            }
        }
        .onAppear {
            viewModel.getCourseSemester(semester: semester, token: appData.token)
        }
        .refreshable {
            viewModel.getCourseSemester(semester: semester, token: appData.token)
        }
        .background(Color.mainBackgroundColor)
        .navigationBarTitle("Khoá học kì \(semester) 🐸", displayMode: .large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonBackUIView()
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.isSheetPresented = true
                }, label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 34)
                        .foregroundStyle(
                            Color.white,
                            Color.mainColor1.gradient
                        )
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 0.1)
                        )
                        .padding(3)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                })
            }
        }
        .sheet(isPresented: $viewModel.isSheetPresented) {
            NavigationView {
                ScrollView {
                    VStack {
                        HStack {
                            Text("CHUYÊN NGÀNH")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.gray)

                            Spacer()
                        }
                        .padding(.horizontal, 30)
                        CustomPicker(selectedOption: $filterCategoryMajor, options: optionsCategories)
                            .frame(height: UIScreen.main.bounds.height * 0.05)

                        Spacer()
                    }
                }
                .navigationTitle("📚 Sắp xếp theo")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            viewModel.isSheetPresented = false
                        }, label: {
                            Text("Save")
                                .font(.system(size: 18, weight: .semibold))
                        })
                    }
                }
            }
            .presentationDetents([.medium, .large])
        }
    }
}

let optionsCategories = ["Chọn Chuyên Ngành", "SE"]

#Preview {
    NavigationStack {
        CourseSemesterView(semester: 9)
    }
}
