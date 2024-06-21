//
//  ResultQuizView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/6/24.
//

import SwiftUI

struct ResultQuizView: View {
    var resultAnswerd: ResultQuizCalculate
    @State private var showAnswers: Bool = false
    @State private var quizView: Tab = .quiz

    var userCorrectTrueCount: Int {
        resultAnswerd.questions.filter(\.user_correct).count
    }

    var userCorrectFalseCount: Int {
        resultAnswerd.questions.filter { !$0.user_correct && $0.is_answered == true }.count
    }

    var unansweredCount: Int {
        resultAnswerd.questions.filter { !$0.is_answered }.count
    }

    var totalQuestions: Int {
        resultAnswerd.questions.count
    }

    var correctPercentage: Double {
        guard totalQuestions > 0 else { return 0.0 }
        return (Double(userCorrectTrueCount) / Double(totalQuestions)) * 100
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.white)
                .ignoresSafeArea()

            VStack {
                Spacer()

                VStack(spacing: 0) {
                    ResultQuizPieChart(trueAnswer: Double(userCorrectTrueCount), falseAnswer: Double(userCorrectFalseCount), undefinedAnswer: Double(unansweredCount))

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Mã môn học")
                                .font(.system(size: 18, weight: .bold))
                            Text("MKT208c")
                                .font(.system(size: 16, weight: .regular))
                        }
                        Spacer()
                        Divider().frame(height: 40)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Người tạo")
                                .font(.system(size: 18, weight: .bold))
                            Text("Nguyễn Huy Khải")
                                .font(.system(size: 16, weight: .regular))
                        }
                    }
                    .padding(.horizontal, 30)

                    Button(action: {
                        showAnswers.toggle()
                    }, label: {
                        HStack {
                            Text("Đáp án của bạn")
                            Image(systemName: "list.clipboard")
                        }
                    })
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .foregroundStyle(Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.green, lineWidth: 3)
                    )
                    .cornerRadius(8)
                    .padding(.vertical, 20)
                }
                .padding(.vertical, 20)
                .ignoresSafeArea()
                .background(.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

                HStack {
                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: "gobackward")
                            Text("Làm lại")
                        }
                        .bold()
                    })
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .foregroundStyle(.white)
                    .background(Color.green)
                    .cornerRadius(8)

                    NavigationLink {
                        CustomHomeView(activeTab: $quizView)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                            Text("Kết thúc")
                        }
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .foregroundColor(.white) // Use foregroundColor instead of foregroundStyle for simplicity
                        .background(Color.red) // Replace `Color.falseAnswer` with a color, e.g., `.red`
                        .cornerRadius(8)
                    }
                }
                .padding(.top, 20)
                Spacer()
            }
            .padding(.horizontal, 15)
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showAnswers) {
            Text("Danh sách đáp án của bạn: ")
                .font(.system(size: 20, weight: .bold))
                .padding(.top, 20)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            ResultListAnswer(listAnswerd: resultAnswerd.questions)
                .presentationDetents([.height(600), .height(650)])
        }
    }
}

#Preview {
    ResultQuizView(resultAnswerd: ResultQuizCalculate.mockData)
}
