//
//  CourseSyllabusTabView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 14/5/24.
//

import SwiftUI

struct CourseSyllabusTabView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(0 ..< 2) {
                        _ in
                        ExpandableView(
                            thumbnail: ThumbnailView(content: {
                                VStack(spacing: 11) {
                                    // Dynamic variable
                                    Text("Khoảng 3 giờ 0 phút")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundStyle(Color(hex: "#8D8A8A"))
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                    HStack(alignment: .top, spacing: 10) {
                                        Image("Week")
                                        Text("JPD113 Buổi 1,2 - Spring 2022")
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                                    HStack {
                                        Text("Đã hoàn thành")
                                            .font(.system(size: 12, weight: .medium))
                                        Spacer()
                                    }
                                }
                                .padding(14)

                            }),
                            expanded: ExpandedView(content: {
                                VStack {
                                    VStack(spacing: 11) {
                                        // Dynamic variable
                                        Text("Khoảng 3 giờ 0 phút")
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundStyle(Color(hex: "#8D8A8A"))
                                            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                        HStack(alignment: .top, spacing: 10) {
                                            Image("Week")
                                            Text("JPD113 Buổi 1,2 - Spring 2022")
                                                .font(.system(size: 14, weight: .medium))
                                        }
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                                        HStack {
                                            Text("Đã hoàn thành")
                                                .font(.system(size: 12, weight: .medium))
                                            Spacer()
                                        }
                                    }
                                    .padding(14)

                                    LazyVStack(spacing: 2) {
                                        ForEach(0 ..< 2) { i in
                                            HStack(spacing: 20) {
                                                Image(systemName: "play.circle")
                                                    .font(.system(size: 20, weight: .regular))
                                                Text("Bài \(i + 1)")
                                                Spacer()
                                                Text("3 giờ")
                                                    .font(.system(size: 12, weight: .regular))
                                            }
                                            .padding(20)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(hex: "#EDEDED"))
                                        }
                                    }
                                }

                            }))
                    }
                }
            }
            .scrollIndicators(.never)
        }
    }
}

#Preview {
    CourseSyllabusTabView()
}
