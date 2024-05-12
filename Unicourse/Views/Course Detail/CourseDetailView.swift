//
//  CourseDetailView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 9/5/24.
//

import SwiftUI

struct CourseDetailView: View {
    @State private var isFav: Bool = false
    @State private var tabSelection = 0
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(Color.mainBackgroundColor)
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 16) {
                    // Go Back Button - Favourite Button - Share Button
                    VStack {
                        HStack {
                            Button(action: {
                                dismiss()
                            }, label: {
                                CircleButtonUI(isActive: false, systemName: "arrow.left", symbolRenderingMode: .multicolor)
                            }).tint(.black)
                            Spacer()
                            Group {
                                Button(action: {
                                    isFav.toggle()
                                }, label: {
                                    CircleButtonUI(isActive: isFav, systemName: "heart", symbolRenderingMode: .multicolor)
                                }).tint(.black)

                                Button(action: {}, label: {
                                    CircleButtonUI(isActive: false, systemName: "arrowshape.turn.up.right", symbolRenderingMode: .multicolor)
                                }).tint(.black)
                            }
                        }

                        Image("3diconsiconcourse")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 237, height: 237)
                        Spacer()
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#DAE9DA"))
                    .clipShape(RoundedRectangle(cornerRadius: 24.0))
                    // Go Back Button - Favourite Button - Share Button

                    // Basic info
                    BasicInfo(courseName: "Khóa học OSG202 - Hệ điều hành", courseAvgRating: 4.3, courseTotalRatingCount: 300, memberCount: 398)
                    // End basic info

                    // Tab bar
                    VStack {
                        TabSelectionView(tabSelection: $tabSelection)
                        TabView(selection: $tabSelection) {
                            CourseDetailTabView()
                                .tag(0)
                            Text("Tag 2")
                                .tag(1)
                            CourseReviewTabView()
                                .tag(2)
                        }
                        .frame(height: 400)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .padding(.bottom, 70)
                    }

                    // Main View
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 18)

            VStack {
                Button(action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/, label: {
                    ButtonGradientUI(titleButton: "Bắt đầu học")
                })
            }
            .padding(.horizontal, 20)
            .background(.white)
        }
    }
}

#Preview {
    CourseDetailView()
}
