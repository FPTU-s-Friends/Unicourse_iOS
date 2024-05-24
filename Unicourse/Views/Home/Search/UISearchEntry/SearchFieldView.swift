//
//  SearchFieldView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 9/5/24.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding var searchString: String
    var action: () -> Void
    @Binding var isFilterIconHidden: Bool
    @Binding var isNavigateToResultView: Bool
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        HStack {
            Button(action: {
                action()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 20))
                    .padding(.trailing, 10)
                    .foregroundColor(.black)
                    .frame(width: 12, height: 24)
            })

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.blue)
                    TextField("Bạn muốn học gì hôm nay ?", text: $searchString)
                        .font(Font.custom("SF Pro Display", size: 14))
                        .lineSpacing(20)
                        .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.76))
                        .padding(.horizontal, 4)
                        .padding(.vertical, 8)
                        .focused($isTextFieldFocused)
                        .onChange(of: isTextFieldFocused) { newValue in
                            withAnimation {
                                isFilterIconHidden = newValue
                            }
                        }

                        .onSubmit {
                            isNavigateToResultView = true
                        }
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
            if !isFilterIconHidden {
                HStack(spacing: 8) {
                    Image("filterIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                }
                .padding(8)
                .background(.white)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .inset(by: 0.25)
                        .stroke(Color(red: 0.26, green: 0.52, blue: 0.96), lineWidth: 0.25)
                )
            }
        }
        .padding(EdgeInsets(top: 6, leading: 18, bottom: 6, trailing: 18))
        .frame(width: 375, height: 56)
    }
}

#Preview {
    SearchFieldView(searchString: .constant(""), action: {}, isFilterIconHidden: .constant(false), isNavigateToResultView: .constant(false))
}
