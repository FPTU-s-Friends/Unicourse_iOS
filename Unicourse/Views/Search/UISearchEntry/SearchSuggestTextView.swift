//
//  SearchSuggestTextView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 24/5/24.
//

import SwiftUI

struct SearchSuggestTextView: View {
    @Binding var searchText: String

    var body: some View {
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            VStack {
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
        }
    }
}

#Preview {
    SearchSuggestTextView(searchText: .constant(""))
}
