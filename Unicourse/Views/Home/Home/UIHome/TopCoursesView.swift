//
//  TopCoursesView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct TopCoursesView: View {
    var body: some View {
        HeaderCategoryView(textCategory: "Khoá học nổi bật",
                           textButton: "Xem thêm",
                           action: {})

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< 6) { _ in
                    ZStack {
                        ZStack(alignment: .topTrailing) {
                            Image("courseImage2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)

                            VStack {
                                Text("Now")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .padding(5)
                                    .padding(.horizontal, 10)
                                    .background(Color.activeColor.cornerRadius(10))
                            }
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        }

                        VStack(alignment: .leading) {
                            Spacer()
                            HStack {
                                Image("User")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)

                                Text("Nguyễn Trung Kiên")
                                    .font(.system(size: 12, weight: .light))
                                    .foregroundStyle(.gray)
//                                    .padding(5)
//                                    .background(Color.activeColor.cornerRadius(10))

                                Spacer()

                                Text("01:42:56")
                                    .font(.system(size: 12, weight: .light))
                                    .foregroundStyle(.gray)
                            }

                            Text("CEA201 - Kiến trúc máy tính")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                        .padding(10)
                    }
                    .frame(width: 270)
                    .cornerRadius(20)
                    .padding(.leading, 10)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    TopCoursesView()
}
