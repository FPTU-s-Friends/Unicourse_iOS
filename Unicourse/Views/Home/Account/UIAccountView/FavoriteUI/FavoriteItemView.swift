//
//  FavoriteItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 29/5/24.
//

import SwiftUI

struct FavoriteItemView: View {
    var wishItem: WisListUserInfo

    var body: some View {
        NavigationLink(destination: CourseDetailView(courseId: wishItem._id)) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    AsyncImage(url: URL(string: wishItem.thumbnail)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.horizontal, 5)
                            .frame(width: 120, height: 100)

                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 120, height: 100)
                            .padding(.horizontal, 5)
                            .shimmerWithWave()
                    }
                    .cornerRadius(10)
                    VStack(alignment: .leading) {
                        Text(wishItem.title)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.black)

                        HStack {
                            AsyncImage(url: URL(string: wishItem.lecture.profile_image)) { image in
                                image.resizable()
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                                    .cornerRadius(20)
                            } placeholder: {
                                ZStack {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 20, height: 20)
                                }
                            }

                            Text(wishItem.lecture.fullName)
                                .font(.system(size: 10, weight: .light))
                                .foregroundStyle(.gray)
                        }

                        RatingStars(rating: 3.5, maxRating: 5)

                        HStack {
                            Text("\(wishItem.amount) VND")
                                .font(.system(size: 12, weight: .bold))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                .foregroundColor(.activeColor)
                            // ---
                            Text("\(wishItem.amount + 10000) VND")
                                .font(.system(size: 10, weight: .bold))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                .strikethrough()
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
        }
        .background(Color.white.cornerRadius(10))
    }
}

#Preview {
    FavoriteItemView(wishItem: WisListUserInfo.sampleData)
}
