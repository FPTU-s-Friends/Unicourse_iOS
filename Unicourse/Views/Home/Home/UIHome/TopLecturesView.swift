//
//  TopLecturesView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct TopLecturesView: View {
    var listLectures: [LectureModel]

    var body: some View {
        HeaderCategoryView(textCategory: HeaderCategoryText.topLecturesText,
                           textButton: TextButton.viewMore,
                           action: {})

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(listLectures, id: \._id) { lecture in
                    VStack {
                        AsyncImage(url: URL(string: lecture.profile_image)!) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())

                        } placeholder: {
                            ProgressView()
                        }

                        Text(lecture.fullName)
                            .font(.system(size: 10, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            .frame(width: 100)
                    }
                }
            }
        }
    }
}

#Preview {
    TopLecturesView(listLectures: [])
}
