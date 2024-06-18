//
//  AnswerCard.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 1/6/24.
//

import SwiftUI

enum Type_Question: String, Codable {
    case single
    case multiple
}

struct AnswerComponent: View {
    @State private var listMultipleAnswer: [Int] = []
    @State private var selectedAnswerIndex: Int? = nil
    @State private var isExpandedAnswer: Bool = false

    var typeAnswer: Type_Question
    var listAnswer: [AnswerRequest]
    var isShowAnswer: Bool
    var question_id: String
    @ObservedObject var vm: DetailQuizViewModel

    var newListAnswer: [AnswerRequest] {
        vm.answeredQuesList.first { question in
            question._id == question_id
        }?.answer ?? []
    }

    var body: some View {
        VStack(spacing: 15) {
            if typeAnswer == .single {
                ForEach(Array(newListAnswer.enumerated()), id: \.element.id) { index, answer in
                    AnswerItem(isSelected: newListAnswer[index].is_checked, index: index, answerType: .single, answerTitle: answer.answer_text)
                        .animation(.spring, value: isShowAnswer)
                        .offset(y: isShowAnswer ? 0 : CGFloat(-65 * index))
                        .opacity(isShowAnswer ? 1 : 0)
                        .onTapGesture {
                            withAnimation {
                                selectedAnswerIndex = index
                                vm.setCheckedForIndexAnswer(questionId: question_id, indexAnswered: index)
//                                print("*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=")
//                                print("*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=")
//                                printJSONData(data: vm.answeredQuesList)
//                                print("*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=")
//                                print("*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=")
                            }
                        }
                        .onChange(of: isShowAnswer) { _, newValue in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) {
                                isExpandedAnswer = newValue
                            }
                        }
                }

            } else {
                ForEach(Array(listAnswer.enumerated()), id: \.element.answer_text) { index, answer in
                    AnswerItem(isSelected: newListAnswer[index].is_checked, index: index, answerType: .multiple, answerTitle: answer.answer_text)
                        .animation(.spring, value: isShowAnswer)
                        .offset(y: isShowAnswer ? 0 : CGFloat(-65 * index))
                        .opacity(isShowAnswer ? 1 : 0)
                        .onTapGesture {
                            withAnimation {
                                handleSelectAnswerTypeMultiple(listMultiple: &listMultipleAnswer, item: index)
                                vm.setCheckedForMultipleAnswer(questionId: question_id, indexAnswered: index)
//                                printJSONData(data: newListAnswer)
                            }
                        }
                        .onChange(of: isShowAnswer) { _, newValue in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) {
                                isExpandedAnswer = newValue
                            }
                        }
                }
            }
        }
        .padding(.horizontal, 20)
    }

    func handleSelectAnswerTypeMultiple(listMultiple: inout [Int], item: Int) {
        if let index = listMultiple.firstIndex(of: item) {
            listMultiple.remove(at: index)
        } else {
            listMultiple.append(item)
        }
    }
}

// #Preview {
//    AnswerComponent(typeAnswer: .multiple, listAnswer: [], isShowAnswer: true)
// }
