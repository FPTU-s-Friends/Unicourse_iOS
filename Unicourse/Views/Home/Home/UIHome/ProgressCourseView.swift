//
//  ProgressView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct ProgressCourseView: View {
    var body: some View {
        HeaderCategoryView(textCategory: "Tiến trình",
                           textButton: "Tất cả",
                           action: {})

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0 ... 10, id: \.self) { _ in
                    VStack {
                        HStack(alignment: .top) {
                            Image(systemName: "character.book.closed.fill")
                                .font(.system(size: 18))
                                .padding(12)
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 0.5)
                                )
                                .padding(2) // Tăng khoảng cách giữa hình ảnh và viền bo
                            Text("MAD101 - Toán rời rạc")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.top, 5)
                        }
                        HStack {
                            CustomProgressView(value: 44, total: 100)
                                .frame(width: 160)
                            Text("44%")
                                .font(.system(size: 16))
                                .padding(6)
                                .foregroundStyle(Color.white)
                                .background(Color.activeColor.cornerRadius(20))
                        }
                        .padding(.bottom, 10)

                        HStack {
                            Image(systemName: "text.book.closed")
                            Text("Chương 3")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            Spacer()
                            Button(action: {}, label: {
                                Text("Tiếp tục")
                                    .font(.system(size: 12, weight: .semibold))
                                    .frame(width: 100, height: 30)
                                    .foregroundStyle(.white)
                                    .background(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom))
                                    .cornerRadius(10)
                            })
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                }
            }
            .background(.white)
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    ProgressCourseView()
}
