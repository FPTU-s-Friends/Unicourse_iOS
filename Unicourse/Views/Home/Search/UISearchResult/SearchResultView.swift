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
                            NavigationLink(destination: CourseDetailView(courseDetail: CourseModel.sampleData)) {
                                SearchResultItemView(courseItem: .sampleData)
                            }
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
