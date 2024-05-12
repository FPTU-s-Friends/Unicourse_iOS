//
//  SemesterChoosenView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct SemesterChosenView: View {
    var body: some View {
        HeaderCategoryView(textCategory: "Danh mục",
                           textButton: "Xem thêm",
                           action: {})

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0 ..< 7) { i in
                    VStack {
                        Image(systemName: "character.book.closed.fill")
                            .foregroundStyle(i == 0 ? .white : .black)
                            .font(.system(size: 18))
                            .padding(16)
                            .background(i == 0 ? Color.activeColor : .white)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )

                        Text("Kỳ \(i + 1)")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    SemesterChosenView()
}
