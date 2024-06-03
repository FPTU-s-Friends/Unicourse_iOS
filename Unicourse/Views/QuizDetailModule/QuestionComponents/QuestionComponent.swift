//
//  QuestionCard.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 1/6/24.
//

import SwiftUI

struct QuestionComponent: View {
    @Binding var isOpenQuestion: Bool
    @Binding var isChangeYAxisQuestion: Bool
    var questionTitle: String
    var questionIndex: Int

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                    .frame(height: 250)
                    .offset(y: 10)
                    .overlay(
                        Text(questionTitle)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black)
                            .padding()
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .padding(.horizontal, 10)

                if isChangeYAxisQuestion != true {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 250)
                            .foregroundStyle(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: .red, location: 0.0),
                                        Gradient.Stop(color: .orange, location: 0.17),
                                        Gradient.Stop(color: .yellow, location: 0.33),
                                        Gradient.Stop(color: .green, location: 0.5),
                                        Gradient.Stop(color: .blue, location: 0.67),
                                        Gradient.Stop(color: .indigo, location: 0.83),
                                        Gradient.Stop(color: .purple, location: 1.0),
                                    ],
                                    startPoint: UnitPoint(x: 0, y: 0.5),
                                    endPoint: UnitPoint(x: 1, y: 0.5)
                                )
                            )
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            .padding(.horizontal, 8)

                        Text("Câu hỏi \(questionIndex)")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .offset(y: isOpenQuestion ? -250 : 0)
                    .scaleEffect(isOpenQuestion ? 1.2 : 1)
                    .rotationEffect(Angle(degrees: isOpenQuestion ? 30 : 0))
                    .rotation3DEffect(
                        Angle(degrees: isOpenQuestion ? 30 : 0),
                        axis: (x: 1, y: 0, z: 0),
                        anchor: .center,
                        anchorZ: 0.0,
                        perspective: 1
                    )
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isOpenQuestion.toggle()
                        }
                    }
                }
            }
            .padding(.bottom, 30)
        }
    }
}

// #Preview {
//    var ques: String = "According to this module, universities are not just trying to train you for a job role, but are also trying to prepare you . . . Refer to lesson 1.4a. Choose one option"
//    QuestionComponent(isOpenQuestion: .constant(false), isChangeYAxisQuestion: .constant(false), questionTitle: ques)
// }
