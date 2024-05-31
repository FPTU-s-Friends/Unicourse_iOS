//
//  NotfoundMyCourseLecture.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 31/5/24.
//

import SwiftUI

struct NotfoundMyCourseLecture: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "shippingbox.fill")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(Color.gray)
            Text("Giảng viên hiện chưa có khoá học nào !")
                .font(.system(size: 12, weight: .light))
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 0.2) // Thêm viền với màu xám và độ dày 2
        )
        .padding(.trailing, 20)
        .padding(.leading, 10)
    }
}

#Preview {
    NotfoundMyCourseLecture()
}
