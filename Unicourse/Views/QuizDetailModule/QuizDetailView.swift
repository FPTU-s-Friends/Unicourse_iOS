//  TestQuiz.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 31/5/24.
//

import SwiftUI

struct QuizDetailView: View {
    @StateObject var vm = DetailQuizViewModel()
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.mainColor3)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                // Phần Progress
                ProgressBarComponent(value: 30.0, total: 100.0)
                // End: Phần Progress

                // Phần Câu hỏi & Các đáp án
                TabView {
                    ForEach(vm.data[0].questions, id: \._id) { question in
                        CombineQnA(question: question)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .background(.white)
                .cornerRadius(35)
                // End: Phần Câu hỏi & Các đáp án

                // Phần [Next] & [Prev] button -> Dùng để navigate giữa các câu hỏi
                NavigationQuizButtonComponents()
                // End: Phần [Next] & [Prev] button -> Dùng để navigate giữa các câu hỏi
            }
            .padding(.horizontal, 10)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Text("📚 MKT208c")
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
        QuizDetailView()
    }
}
