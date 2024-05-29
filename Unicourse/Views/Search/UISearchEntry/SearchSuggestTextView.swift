//
//  SearchSuggestTextView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 24/5/24.
//

import SwiftUI

struct SearchSuggestTextView: View {
    @Binding var searchText: String
    var suggestions: [SearchSuggestModel]
    @State private var showAllSuggestions = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            VStack(spacing: 8) {
                ForEach(suggestions.indices, id: \.self) { index in
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
                            withAnimation {
                                searchText = suggestions[index].searchString
                            }
                        }) {
                            HStack {
                                Text(suggestions[index].searchString)
                                    .font(.system(size: 14, weight: .semibold))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                    .lineSpacing(20)
                                Spacer()

                                AsyncImage(url: URL(string: suggestions[index].urlImage)) { image in
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
        }
    }
}

#Preview {
    SearchSuggestTextView(searchText: .constant("zxc"), suggestions: [
        SearchSuggestModel(searchString: "MAD", urlImage: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Course%2FCN8%2FPRM392.png?alt=media&token=a2164ded-1dc9-47c6-b952-b499872868b4"),
        SearchSuggestModel(searchString: "Hoang NT", urlImage: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Course%2FCN8%2FPRM392.png?alt=media&token=a2164ded-1dc9-47c6-b952-b499872868b4"),
        SearchSuggestModel(searchString: "UI Design for beginner", urlImage: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Course%2FCN8%2FPRM392.png?alt=media&token=a2164ded-1dc9-47c6-b952-b499872868b4"),
        SearchSuggestModel(searchString: "Cấu trúc dữ liệu và giải thuật", urlImage: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Course%2FCN8%2FPRM392.png?alt=media&token=a2164ded-1dc9-47c6-b952-b499872868b4")
    ])
}
