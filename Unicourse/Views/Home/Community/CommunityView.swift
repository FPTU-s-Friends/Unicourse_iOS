//
//  CommunityView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct CommunityView: View {
    @State var searchString: String = ""

    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBackgroundColor.ignoresSafeArea()

            VStack {
                VStack {
                    // Header Cards
                    HStack {
                        Text("Cộng Đồng")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                        Spacer()

                        Button(action: {}, label: {
                            Image(systemName: "bell")
                                .font(.system(size: 20))
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color.activeButtonColor)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 0.1)
                                )
                        })
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 10)

                    // Search Field
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 8) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.blue)
                                TextField("Tìm kiếm", text: $searchString)
                                    .font(.system(size: 14, weight: .semibold))
                                    .lineSpacing(20)
                                    .foregroundStyle(.gray)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 8)
                            }
                            .padding(12)
                            .frame(height: 44)
                            .background(.white)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .inset(by: 0.25)
                                    .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 0.25)
                            )
                        }
                    }
                    .padding(EdgeInsets(top: 6, leading: 18, bottom: 6, trailing: 18))
                    .frame(width: 375, height: 56)
                }
                .padding([.horizontal, .bottom], 18)
                .safeAreaPadding(.top, 60)
                .frame(maxWidth: .infinity)
                .background(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(40)

                ScrollView {
                    ForEach(1 ..< 10) { _ in
                        ChatGroupMiniView()
                    }
                }

                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CommunityView()
}
