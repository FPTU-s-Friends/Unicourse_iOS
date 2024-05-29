//
//  RecentView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct RecentView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @EnvironmentObject var appData: AppData
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var searchString: String = ""
    @State private var isSearchBarVisible: Bool = false

    var filteredCourses: [EnrollCourseUserInfo] {
        let courses = appData.userInfo?.enrollCourses ?? []
        if searchString.isEmpty {
            return courses.sorted(by: { $0.enrollDate > $1.enrollDate })
        } else {
            return courses.filter { $0.courseId.title.localizedCaseInsensitiveContains(searchString) }
                .sorted(by: { $0.enrollDate > $1.enrollDate })
        }
    }

    var body: some View {
        List {
            ForEach(filteredCourses, id: \._id) { course in
                NavigationLink(destination: CourseDetailView(courseId: course.courseId._id)) {
                    RecentItemView(enrollCourse: course)
                }
            }
        }
        .padding(.horizontal, -5)
        .searchable(text: $searchString, isPresented: $isSearchBarVisible, placement: .navigationBarDrawer, prompt: Text("Tìm kiếm"))
        .background(Color.mainBackgroundColor)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    withAnimation {
                        isSearchBarVisible.toggle()
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecentView()
            .environmentObject(AppData())
    }
}
