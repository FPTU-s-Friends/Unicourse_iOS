//
//  TopLecturesView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct TopLecturesView: View {
    var body: some View {
        HeaderCategoryView(textCategory: "Giảng viên nổi bật", textButton: "Xem thêm", action: {})

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0 ..< 6) { _ in
                    VStack {
                        Image("kien")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())

                        Text("Trung Kiên")
                    }
                }
            }
            .padding(.leading, 10)
        }
    }
}

#Preview {
    TopLecturesView()
}
