//
//  SearchResultItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct SearchResultItemView: View {
    var courseItem: CourseModel

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                VStack {
                    AsyncImage(url: URL(string: courseItem.thumbnail)!) { image in
                        image.resizable()
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 165)

                    } placeholder: {
                        ProgressView()
                    }
                }
                .frame(width: 190)

                VStack {
                    HStack {
                        AsyncImage(url: URL(string: courseItem.lecture!.profile_image)!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 34)
                                .cornerRadius(30)

                        } placeholder: {
                            ProgressView()
                        }

                        Text(courseItem.lecture!.fullName)
                            .font(.system(size: 10, weight: .medium))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal, 15)

                Text(courseItem.title)
                    .font(.system(size: 12))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .padding(.horizontal, 15)

                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("229.000 vnđ")
                        .font(.system(size: 12, weight: .bold))
                        .lineSpacing(20)
                        .foregroundColor(.mainColor1)
                    Text("339.000 vnđ")
                        .font(.system(size: 10))
                        .lineSpacing(20)
                        .strikethrough()
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            }

            RatingStars(rating: 4)
                .offset(x: -40, y: 140)
        }
        .frame(width: 180, height: 260)
        .background(.white)
        .cornerRadius(12)
    }
}

#Preview {
    SearchResultItemView(courseItem: CourseModel.sampleData)
}
