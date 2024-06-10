//  TestQuiz.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 31/5/24.
//

import SwiftUI

struct QuizDetailView: View {
    var quizId: String
    @ObservedObject var vm = DetailQuizViewModel()

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.mainColor3)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                // Phần Progress
                ProgressBarComponent(value: Double(vm.selectedTab + 1), total: Double(vm.quizData?.questions.count ?? 2))
                // End: Phần Progress

                // Phần Câu hỏi & Các đáp án
                TabView(selection: $vm.selectedTab) {
                    ForEach(Array((vm.answeredQuesList).enumerated()), id: \.element._id) { index, question in
                        CombineQnA(question: question, questionIndex: index + 1, vm: vm)
                            .tag(index)
                    }
                }
                .animation(.easeInOut, value: vm.selectedTab)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .background(.white)
                .cornerRadius(35)
                .onAppear {
                    // Ngăn ng dùng swipe
                    UIScrollView.appearance().isScrollEnabled = false
                }

                // End: Phần Câu hỏi & Các đáp án

                // Phần [Next] & [Prev] button -> Dùng để navigate giữa các câu hỏi
                NavigationQuizButtonComponents(totalQuestion: vm.quizData?.questions.count ?? 1, vm: vm, selectedTab: $vm.selectedTab)

                // End: Phần [Next] & [Prev] button -> Dùng để navigate giữa các câu hỏi
            }
            .padding(.horizontal, 10)

            if vm.isLoading {
                LoadingIndicatorView(isLoading: .constant(true))
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                vm.getQuizById(quizId: quizId)
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonBackUIView()
            }

            ToolbarItem(placement: .topBarTrailing) {
                Text("📚 \(vm.quizData?.title ?? "")")
                    .bold()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    NavigationStack {
        QuizDetailView(quizId: "663692241945fbdc90782da5")
    }
}
