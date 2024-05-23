//
//  CourseSemesterView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

struct CourseSemesterView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @StateObject var viewModel = CourseSemesterViewModel()
    var semester: Int

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 5)], spacing: 10) {
                    ForEach(0 ..< 4) { _ in
                        NavigationLink(destination: CourseDetailView(courseId: "65a8790ba30979a347d026c9")) {
                            SearchResultItemView()
                        }
                    }
                }
            }
        }
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
    }
}

#Preview {
    NavigationStack {
        CourseSemesterView(semester: 9)
    }
}
