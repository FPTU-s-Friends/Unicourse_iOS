//
//  SearchResultView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 10/5/24.
//

import SwiftUI

struct SearchResultView: View {
    @State var activeTab = "Liên quan"
    @Environment(\.dismiss) private var dismiss
    @Binding var searchString: String
    @Binding var isFilterIconHidden: Bool
    @Binding var isNavigateToResultView: Bool

    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea(.all)

            VStack {
                SearchFieldView(
                    searchString: $searchString,
                    action: { dismiss() },
                    isFilterIconHidden: $isFilterIconHidden,
                    isNavigateToResultView: $isNavigateToResultView
                )
                ResultUserView()

                HStack {
                    TabButton(title: "Liên quan", isActive: activeTab == "Liên quan") {
                        activeTab = "Liên quan"
                    }

                    Spacer()

                    TabButton(title: "Mới nhất", isActive: activeTab == "Mới nhất") {
                        activeTab = "Mới nhất"
                    }

                    Spacer()

                    TabButton(title: "Giảm giá", isActive: activeTab == "Giảm giá") {
                        activeTab = "Giảm giá"
                    }
                }
                .padding(20)

                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 5)], spacing: 10) {
                        ForEach(0 ..< 4) { _ in
                            ZStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    VStack {
                                        Image("courseImageEx")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                    .frame(width: 190)
                                    .padding(.top, 10)

                                    VStack {
                                        HStack {
                                            Image("User")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20)

                                            Text("Đinh Gia Bảo")
                                                .font(.system(size: 10, weight: .medium))
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                    .padding(.horizontal, 15)

                                    Text("WDU203c - The UI/UX Design")
                                        .font(.system(size: 12))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                        .truncationMode(.tail)
                                        .padding(.horizontal, 15)

                                    Spacer()
                                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                                        Text("229.000 vnđ")
                                            .font(.system(size: 12, weight: .bold))
                                            .lineSpacing(20)
                                            .foregroundColor(.mainColor1)
                                        Text("339.000 vnđ")
                                            .font(.system(size: 10))
                                            .lineSpacing(20)
                                            .strikethrough()
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.horizontal, 15)
                                    .padding(.bottom, 10)
                                }

                                HStack(alignment: .top, spacing: 4) {
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 8)
                                        .foregroundColor(.yellow)

                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 8)
                                        .foregroundColor(.yellow)

                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 8)
                                        .foregroundColor(.yellow)

                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 8)
                                        .foregroundColor(.yellow)

                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 8)
                                        .foregroundColor(.yellow)
                                }
                                .padding(2)
                                .background(Color(red: 1, green: 1, blue: 1).opacity(0.50))
                                .cornerRadius(5)
                                .padding(.horizontal, 5)
                                .offset(x: -40, y: 160)
                            }
                            .frame(width: 180, height: 260)
                            .background(.white)
                            .cornerRadius(12)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SearchResultView(searchString: .constant(""), isFilterIconHidden: .constant(false), isNavigateToResultView: .constant(false))
}
