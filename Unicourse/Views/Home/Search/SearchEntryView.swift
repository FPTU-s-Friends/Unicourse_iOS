//
//  SearchEntryView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 9/5/24.
//

import SwiftUI

struct SearchEntryView: View {
    @StateObject var viewModel = SearchEntryViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 5) {
            // Search Field
            SearchFieldView(
                searchString: $viewModel.searchString,
                action: { dismiss() },
                isFilterIconHidden: $viewModel.isFilterIconHidden,
                isNavigateToResultView: $viewModel.isNavigateToResultView
            )

            // Search Matching
            if !viewModel.searchString.trimmingCharacters(in: .whitespaces).isEmpty {
                VStack {
                    HStack {
                        Text("MAD")
                            .font(.system(size: 14, weight: .semibold))
                            .lineSpacing(20)

                        Spacer()

                        Image(systemName: "clock")
                    }
                    .padding(10)
                }

                VStack {
                    HStack {
                        Text("Hoang NT")
                            .font(.system(size: 14, weight: .semibold))
                            .lineSpacing(20)

                        Spacer()

                        Image(systemName: "lightbulb.led.wide")
                    }
                    .padding(10)
                }

                VStack {
                    HStack {
                        Text("UI Design for beginner")
                            .font(.system(size: 14, weight: .semibold))
                            .lineSpacing(20)

                        Spacer()

                        Image(systemName: "pencil.circle")
                    }
                    .padding(10)
                }
                VStack {
                    HStack {
                        Text("Cấu trúc dữ liệu và giải thuật")
                            .font(.system(size: 14, weight: .semibold))
                            .lineSpacing(20)

                        Spacer()

                        Image(systemName: "person")
                    }
                    .padding(10)
                }

                Button(action: {}, label: {
                    Text("Xem thêm")
                        .font(.system(size: .mainTitleButtonPath))
                        .foregroundStyle(.white)
                        .padding(6)
                        .padding(.horizontal, 10)
                        .background(Color.activeButtonColor.cornerRadius(20))
                })
            }
//            Suggest Course
            SuggestCourseView()
        }
        .padding(10)
        .background(Color.mainBackgroundColor)
        .navigationDestination(isPresented: $viewModel.isNavigateToResultView) {
            SearchResultView(
                searchString: $viewModel.searchString,
                isFilterIconHidden: $viewModel.isFilterIconHidden,
                isNavigateToResultView: $viewModel.isNavigateToResultView
            )
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        SearchEntryView()
    }
}
