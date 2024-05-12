//
//  CourseReviewTabView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/5/24.
//

import SwiftUI

struct CourseReviewTabView: View {
    var body: some View {
        VStack(spacing: 26) {
            ScrollView {
                BasicRating()

                // Comment Rating
                LazyVStack {
                    ForEach(0 ..< 3) { _ in
                        CommentRating(memberName: "Kiên")

                        Divider()
                    }
                }
            }
        }
    }
}

#Preview {
    CourseReviewTabView()
}

struct BasicRating: View {
    var body: some View {
        HStack {
            // Large Rating
            VStack(spacing: 9) {
                HStack {
                    Text("4.5")
                        .font(.system(size: 32, weight: .medium))
                    Image(.starRating)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                VStack {
                    Text("Lean Six Sigma và muốn trang bị mình với kiến thức và kỹ năng cần thiết để giải quyết các vấn đề chất lượng một cách hiệu quả? ")
                        .font(Font.custom("SF Pro Display", size: 14))
                        .foregroundColor(Color.neutralTextColor)
                        .frame(width: 122, height: 50, alignment: .topLeading)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/)
            // Rating Level
            VStack(spacing: 1) {
                ForEach(0 ..< 5, id: \.self) { i in
                    HStack(spacing: 10) {
                        HStack(spacing: 1) {
                            Text("\(5 - i)")
                            Image(.starRatingBlue)
                        }
                        CustomProcessRating(value: 28, total: 100)
                        Text("92%")
                    }
                }
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 17)
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 0.1)
        )
        .cornerRadius(16)
    }
}

enum LikeOrDisLike: String {
    case Like = "like"
    case DisLike = "dislike"
    case None = "non"
}

struct CommentRating: View {
    @State var isActive: Bool = false
    @State var isLike: LikeOrDisLike = .None
    let memberName: String

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                // Image
                Image(.kien)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 36, height: 36)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)

                VStack(alignment: .leading) {
                    Text(memberName)
                        .font(.system(size: 14, weight: .medium))
                    RatingStars(rating: 3.4, maxRating: 5)
                    // Rating
                }
                Spacer()
                HStack(spacing: 8) {
                    VStack {
                        Button {
                            isLike = .Like
                            isActive = true
                        } label: {
                            Image(isActive && isLike.rawValue == "like" ? "LikeactiveLike" : "LikelikeUnactive")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .padding(6)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(lineWidth: 0.5)
                                        .foregroundStyle(Color(hex: "#EDEDED"))
                                }
                        }
                        Text("13")
                            .font(.system(size: 10, weight: .regular))
                    }

                    VStack {
                        Button {
                            isLike = .DisLike
                            isActive = true

                        } label: {
                            Image(isActive && isLike.rawValue == "dislike" ? "DislikedislikeActive" : "DislikedislikeUnactive")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .padding(6)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(lineWidth: 0.5)
                                        .foregroundStyle(Color(hex: "#EDEDED"))
                                }
                        }
                        Text("04")
                            .font(.system(size: 10, weight: .regular))
                    }
                }
            }

            Text("Đây là một khoá học thật tuyệt vời, thầy Kiên dạy rất ổn.")
                .font(.system(size: 14))
                .foregroundStyle(Color.neutralTextColor)
                .frame(maxWidth: .infinity)
        }
    }
}
