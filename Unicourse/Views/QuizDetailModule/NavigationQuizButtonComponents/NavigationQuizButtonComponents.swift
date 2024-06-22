//
//  NavigationQuizButtonComponents.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 1/6/24.
//

import SwiftUI

struct NavigationQuizButtonComponents: View {
    @EnvironmentObject var appData: AppData
    var totalQuestion: Int
    var vm: DetailQuizViewModel
    @Binding var selectedTab: Int
    @State private var isShowConfirmResult: Bool = false
    @State private var shouldNavigate = false

    var canClickPrev: Bool {
        if selectedTab > 0 {
            return true
        }
        return false
    }

    var canClickNext: Bool {
        if selectedTab < totalQuestion - 1 {
            return true
        }
        return false
    }

    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                if selectedTab > 0 {
                    selectedTab -= 1
                }
            }, label: {
                HStack {
                    Image(systemName: "arrowtriangle.left.fill")
                    Text("Câu trước")
                }
            })
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .foregroundStyle(canClickPrev ? .white : .gray.opacity(0.5))
            .background(canClickPrev ? Color.activeColor : .white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(canClickPrev ? Color.activeColor : .white, lineWidth: 2)
            )
            .cornerRadius(8)
            .animation(.spring(), value: canClickPrev)

            Button(action: {
                if selectedTab < totalQuestion - 1 {
                    selectedTab += 1
                } else {
                    isShowConfirmResult.toggle()
                    print("!3")
                }
            }, label: {
                if canClickNext {
                    HStack {
                        Text("Câu sau")
                        Image(systemName: "arrowtriangle.right.fill")
                    }
                } else {
                    HStack {
                        Text("Kết quả")
                        Image(systemName: "arrowtriangle.right.fill")
                    }
                }

            })
            .alert(isPresented: $isShowConfirmResult) {
                Alert(title: Text("Bạn có chắc chắn nộp bài?"), primaryButton: .default(Text("Xem ngay")) {
                    vm.createCalculateResultOfQuiz(userId: appData.user?.userId ?? "") {
                        shouldNavigate = true
                    }

                }, secondaryButton: .destructive(Text("Kiểm tra lại")))
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .foregroundStyle(canClickNext ? .white : .white)
            .background(canClickNext ? Color.activeColor : .green)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(canClickNext ? Color.activeColor : .white, lineWidth: 2)
            )
            .cornerRadius(8)
            .animation(.spring(), value: canClickNext)
//            // Navigation link to the result view
//            .navigationDestination(isPresented: $shouldNavigate) {
//                ResultQuizView(resultAnswerd: vm.resultQuesList ?? ResultQuizCalculate.mockData)
//            }
        }
        .navigationDestination(isPresented: $shouldNavigate) {
            ResultQuizView(resultAnswerd: vm.resultQuesList ?? ResultQuizCalculate.mockData)
        }
        .navigationBarBackButtonHidden()
        .padding(.vertical, 10)
    }
}

#Preview {
    NavigationQuizButtonComponents(totalQuestion: 20, vm: DetailQuizViewModel(), selectedTab: .constant(2))
}
