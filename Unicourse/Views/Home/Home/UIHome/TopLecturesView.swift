//
//  TopLecturesView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct TopLecturesView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var listLectures: [LectureModel]
    var body: some View {
        HeaderCategoryView(textCategory: HeaderCategoryText.topLecturesText,
                           textButton: TextButton.viewMore,
                           action: {})

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(listLectures, id: \._id) { lecture in
                    NavigationLink {
                        LectureInfoView(lecture_id: lecture._id)
                    } label: {
                        VStack {
                            AsyncImage(url: URL(string: lecture.profile_image)!) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())

                            } placeholder: {
                                Rectangle()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .shimmerWithWave()
                            }

                            Text(lecture.fullName)
                                .font(.system(size: 10, weight: .semibold))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .lineLimit(1)
                                .frame(width: 100)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TopLecturesView(listLectures: [])
}
