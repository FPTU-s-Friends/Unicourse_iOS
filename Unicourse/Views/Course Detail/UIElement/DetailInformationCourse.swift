//
//  DetailInformationCourse.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/5/24.
//

import SwiftUI

struct DetailInformationCourse: View {
    var body: some View {
        VStack(spacing: 18) {
            HStack(alignment: .top) {
                Image("3diconsiconcourse")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 6.0))

                Text("Khoá học OSG202 - Hệ điều hành")
                    .font(.system(size: 14, weight: .bold))
                Spacer()
            }

            VStack {
                Text("Hiểu sâu hơn về cách Javascript hoạt động, tìm hiểu về IIFE, closure, reference types, ...")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color.neutralTextColor)
                Spacer(minLength: 12)
                Text("Bạn đang tìm hiểu về Lean Six Sigma và muốn trang bị mình với kiến thức và kỹ năng cần thiết để giải quyết các vấn đề chất lượng một cách hiệu quả? Khóa học 7 Công Cụ Chất Lượng cho Lean Six Sigma Yellow Belt là lựa chọn hoàn hảo cho bạn,")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color.neutralTextColor)
                Spacer(minLength: 12)
                Text("1. Hệ điều hành là gì")
                    .font(.system(size: 12, weight: .bold))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                Button {} label: {
                    Text("Xem thêm")
                }
            }
            .frame(maxWidth: 306)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 17)
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 0.1)
        )
        .cornerRadius(16)
    }
}
