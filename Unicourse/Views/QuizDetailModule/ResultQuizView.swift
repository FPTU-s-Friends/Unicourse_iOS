//
//  ResultQuizView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/6/24.
//

import SwiftUI

struct ResultQuizView: View {
    @State private var showAnswers: Bool = false

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.mainColor3)
                .ignoresSafeArea()

            VStack {
                Spacer()
                VStack(spacing: 0) {
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
                    ResultQuizPieChart()
                    Button(action: {
                        showAnswers.toggle()
                    }, label: {
                        HStack {
                            Text("Đáp án của bạn")
                        }
                    })
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .bold()
                    .foregroundStyle(Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.green, lineWidth: 3)
                    )
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                }
                .padding(.vertical, 20)
                .ignoresSafeArea()
                .background(.white)
                .cornerRadius(20)
                .padding(.horizontal, 10)
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

                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: "checkmark")
                            Text("Kết thúc")
                        }
                        .bold()
                    })
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .foregroundStyle(.white)
                    .background(Color.falseAnswer)
                    .cornerRadius(8)
                }
                .padding(.top, 20)
                Spacer()
            }
        }
        .sheet(isPresented: $showAnswers) {
            ResultListAnswer()
                .presentationDetents([.large])
        }
    }
}

#Preview {
    ResultQuizView()
}
