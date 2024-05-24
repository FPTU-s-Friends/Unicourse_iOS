//
//  SuggessCourseView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 10/5/24.
//

import SwiftUI

struct SuggestCourseView: View {
    var listSearchCourse: [SearchCourseModel]

    var body: some View {
        HStack {
            Text("Suggest Search")
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
        Spacer()
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 20)], spacing: 60) {
                ForEach(listSearchCourse, id: \._id) { course in
                    GeometryReader { _ in
                        HStack(spacing: 4) {
                            AsyncImage(url: URL(string: course.thumbnail)!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 70)
                                    .padding(10)
                                    .cornerRadius(20)

                            } placeholder: {
                                ProgressView()
                            }

                            Text(course.title)
                                .font(.system(size: 12))
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .padding(.trailing, 10)
                        }
                        .cornerRadius(10)
                    }
                }
            }
        }
    }
}

#Preview {
    SuggestCourseView(listSearchCourse: [SearchCourseModel.sampleData, SearchCourseModel.sampleData])
}
