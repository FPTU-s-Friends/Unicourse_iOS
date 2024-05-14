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
                    ExpandableView(
                        thumbnail: ThumbnailView(content: {
                            VStack(spacing: 11) {
                                // Dynamic variable
                                Text("Tuần 1: Khoảng 4 tiếng")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(Color(hex: "#8D8A8A"))
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                HStack(alignment: .top, spacing: 10) {
                                    Image("Week")
                                    Text("Giới thiệu về hệ điều hành")
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
                            VStack(spacing: 11) {
                                // Dynamic variable
                                Text("Tuần 1: Khoảng 4 tiếng")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(Color(hex: "#8D8A8A"))
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                HStack(alignment: .top, spacing: 10) {
                                    Image("Week")
                                    Text("Giới thiệu về hệ điều hành")
                                        .font(.system(size: 14, weight: .medium))
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                                HStack {
                                    Text("Đã hoàn thành")
                                        .font(.system(size: 12, weight: .medium))
                                    Spacer()
                                }

                                Text("Chuong 1")
                                Text("Chuong 2")
                                Text("Chuong 3")
                                Text("Chuong 4")
                            }
                            .padding(14)

                        }))
                    ExpandableView(
                        thumbnail: ThumbnailView(content: {
                            VStack(spacing: 11) {
                                // Dynamic variable
                                Text("Tuần 2: Khoảng 4 tiếng")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(Color(hex: "#8D8A8A"))
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                HStack(alignment: .top, spacing: 10) {
                                    Image("Week")
                                    Text("Hệ thống máy chủ")
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
                            VStack(spacing: 11) {
                                // Dynamic variable
                                Text("Tuần 1: Khoảng 4 tiếng")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(Color(hex: "#8D8A8A"))
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                HStack(alignment: .top, spacing: 10) {
                                    Image("Week")
                                    Text("Giới thiệu về hệ điều hành")
                                        .font(.system(size: 14, weight: .medium))
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                                HStack {
                                    Text("Đã hoàn thành")
                                        .font(.system(size: 12, weight: .medium))
                                    Spacer()
                                }

                                Text("Chuong 1")
                                Text("Chuong 2")
                                Text("Chuong 3")
                                Text("Chuong 4")
                            }
                            .padding(14)

                        }))
                    ExpandableView(
                        thumbnail: ThumbnailView(content: {
                            VStack(spacing: 11) {
                                // Dynamic variable
                                Text("Tuần 3: Khoảng 4 tiếng")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(Color(hex: "#8D8A8A"))
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                HStack(alignment: .top, spacing: 10) {
                                    Image("Week")
                                    Text("Binary là gì")
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
                            VStack(spacing: 11) {
                                // Dynamic variable
                                Text("Tuần 1: Khoảng 4 tiếng")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(Color(hex: "#8D8A8A"))
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                HStack(alignment: .top, spacing: 10) {
                                    Image("Week")
                                    Text("Giới thiệu về hệ điều hành")
                                        .font(.system(size: 14, weight: .medium))
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                                HStack {
                                    Text("Đã hoàn thành")
                                        .font(.system(size: 12, weight: .medium))
                                    Spacer()
                                }

                                Text("Chuong 1")
                                Text("Chuong 2")
                                Text("Chuong 3")
                                Text("Chuong 4")
                            }
                            .padding(14)

                        }))
                }
            }
            .scrollIndicators(.never)
        }
    }
}

#Preview {
    CourseSyllabusTabView()
}
