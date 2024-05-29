//
//  SearchSuggestTextView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 24/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct SearchSuggestTextView: View {
    @State private var showAllSuggestions = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel: SearchEntryViewModel
    @State private var navigateToResultView = false

    var body: some View {
        if !viewModel.searchString.trimmingCharacters(in: .whitespaces).isEmpty {
            VStack(spacing: 8) {
                ForEach(viewModel.listSuggestCourse.indices, id: \.self) { index in
                    if !showAllSuggestions && index == 8 {
                        Button(action: {
                            withAnimation {
                                showAllSuggestions.toggle()
                            }
                        }) {
                            Text("Xem thêm")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.activeButtonColor.cornerRadius(20))
                        }
                    }
                    if showAllSuggestions || index < 8 {
                        Button(action: {
                            viewModel.searchString = viewModel.listSuggestCourse[index].searchString
                            navigateToResultView = true
                        }) {
                            HStack {
                                Text(viewModel.listSuggestCourse[index].searchString)
                                    .font(.system(size: 14, weight: .semibold))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                    .lineSpacing(20)
                                Spacer()

                                WebImage(url: URL(string: viewModel.listSuggestCourse[index].urlImage)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 30)
                                        .cornerRadius(5)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            .padding(10)
                        }
                    }
                }
            }
            .padding(.top, 8)
            .navigationDestination(isPresented: $navigateToResultView) {
                SearchResultView(viewModel: viewModel)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    SearchSuggestTextView(viewModel: SearchEntryViewModel())
}
