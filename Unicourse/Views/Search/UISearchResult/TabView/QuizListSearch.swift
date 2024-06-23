//
//  SaleResultTabView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct QuizListSearch: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: SearchEntryViewModel
    var listQuiz: [QuizSearchModel]

    var body: some View {
        ScrollView {
            if listQuiz.isEmpty {
                Text("Không tìm thấy câu hỏi nào phù hợp !")
            } else {
                ForEach(listQuiz.indices, id: \.self) { index in
                    let quiz = listQuiz[index]
                    NavigationLink(destination: QuizDetailView(quizId: quiz._id)) {
                        VStack(alignment: .leading) {
                            WebImage(url: URL(string: quiz.picture)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(10)
                                    .frame(width: UIScreen.main.bounds.width * 0.95)

                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 5)
                                    .shimmerWithWave()
                            }

                            Text(quiz.title)
                                .font(.system(size: 18, weight: .semibold))
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(.primary)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .lineLimit(2)
                                .padding(.horizontal, 5)

                            Text(quiz.description)
                                .font(.system(size: 14, weight: .light))
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(.gray)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .lineLimit(3)
                                .padding(.horizontal, 5)

                            HStack {
                                Text("Học Kỳ: ")
                                    .font(.system(size: 14, weight: .light))
                                    .multilineTextAlignment(.leading)
                                    .foregroundStyle(.gray)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                    .lineLimit(3)
                                    .padding(.leading, 5)

                                Text(quiz.category)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(Color.white)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 6)
                                    .background(Color.green)
                                    .cornerRadius(5)
                            }
                            .padding(.leading, 5)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                    }
                    .onAppear {
                        // Load more content when the last item appears
                        if index == listQuiz.count - 1 {
                            viewModel.loadMore(searchText: viewModel.searchString)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    QuizListSearch(viewModel: SearchEntryViewModel(), listQuiz: [.sampleData])
}
