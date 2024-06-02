//
//  QuizItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 31/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct QuizItemView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var quizItem: AllQuizModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                WebImage(url: URL(string: quizItem.picture)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.horizontal, 5)
                        .frame(width: 130, height: 100)

                } placeholder: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .padding(.horizontal, 5)
                        .frame(width: 130, height: 100)
                        .shimmerWithWave()
                }
                .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text(quizItem.title)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black)

                    HStack(spacing: 5) {
                        WebImage(url: URL(string: quizItem.creator_id.profile_image)) { image in
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

                        Text(quizItem.creator_id.fullName)
                            .font(.system(size: 12, weight: .semibold))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .foregroundStyle(.gray)
                    }

                    HStack(spacing: 5) {
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10)

                        Text("\(quizItem.questions.count) câu hỏi")
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .font(.system(size: 10, weight: .regular))
                            .foregroundStyle(.gray)
                    }
                    .padding(.leading, 5)
                    .padding(.top, 5)

                    HStack {
                        HStack(spacing: 0) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10)
                                .foregroundStyle(Color.green.gradient)

                            Text("\(quizItem.viewer) Đã xem")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .padding(5)
                        }
                        .padding(.horizontal, 5)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)

                        HStack(spacing: 0) {
                            Image(systemName: "clock")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10)
                                .foregroundStyle(Color.blue.gradient)

                            Text("\(timeSinceCreated(date: quizItem.created_at))")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .padding(5)
                        }
                        .padding(.horizontal, 5)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                    }
                }
            }
        }
        .frame(height: 100)
    }
}

#Preview {
    QuizItemView(quizItem: AllQuizModel.sampleData)
}
