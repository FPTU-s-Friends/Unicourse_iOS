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
                            Image("User")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)

                            Text("Nguyễn Trung Kiên")
                                .font(.system(size: 10, weight: .light))
                                .foregroundStyle(.gray)
                        }

                        RatingStars(rating: 3.5, maxRating: 5)

                        HStack {
                            Text("50.000 VND")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.activeColor)
                            // ---
                            Text("70.000 VND")
                                .font(.system(size: 10, weight: .bold))
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
    FavoriteItemView(wishItem: WisListUserInfo(_id: "", title: "", titleDescription: "", thumbnail: "", semester_number: 1))
}
