//  TestQuiz.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 31/5/24.
//

import SwiftUI

struct QuizDetailView: View {
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.mainColor1)
            VStack {
                // Phần Progress
                ProgressBarComponent()
                // End: Phần Progress

                // Phần Câu hỏi & Các đáp án
                TabView {
                    ForEach(0 ..< 3) { _ in
                        CombineQnA()
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .background(.white)
                .cornerRadius(20)
                .padding(.horizontal, 10)
                // End: Phần Câu hỏi & Các đáp án

                // Phần [Next] & [Prev] button -> Dùng để navigate giữa các câu hỏi
                NavigationQuizButtonComponents()
                // End: Phần [Next] & [Prev] button -> Dùng để navigate giữa các câu hỏi
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
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
        }
    }
}

#Preview {
    QuizDetailView()
}
