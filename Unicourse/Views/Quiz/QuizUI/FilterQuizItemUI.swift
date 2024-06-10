//
//  FilterQuizItemUI.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 10/6/24.
//

import SwiftUI

struct FilterQuizItemUI: View {
    @Binding var filterSelected: TypeFilter
    @Binding var filterSelectedOption: Int
    var action: () -> Void

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("CHỌN LỌC")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color.gray)

                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    FilterButton(text: TypeFilter.filterDefault.rawValue, type: .filterDefault, selected: $filterSelected)
                    FilterButton(text: TypeFilter.filterNewest.rawValue, type: .filterNewest, selected: $filterSelected)
                    FilterButton(text: TypeFilter.filterMostView.rawValue, type: .filterMostView, selected: $filterSelected)
                }
                .padding(.bottom, 40)

                VStack {
                    HStack {
                        Text("CHỌN KỲ")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color.gray)

                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    CustomPicker(selectedOption: $filterSelectedOption, options: options)
                        .frame(height: UIScreen.main.bounds.height * 0.05)
                }
            }
            .navigationTitle("📚 Sắp xếp theo")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        action()
                    }, label: {
                        Text("Save")
                            .font(.system(size: 18, weight: .semibold))
                    })
                }
            }
        }
    }
}

struct FilterButton: View {
    let text: String
    let type: TypeFilter
    @Binding var selected: TypeFilter

    var body: some View {
        Button(action: {
            selected = type
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(selected == type ? Color.UIButtonGreen : Color.clear)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.05)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selected == type ? Color.UIButtonGreen : Color.gray.opacity(0.5), lineWidth: 1)
                    )

                Text(text)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(selected == type ? Color.white : Color.black)
            }
        }
    }
}

struct CustomPicker: View {
    @Binding var selectedOption: Int
    let options: [String]

    var body: some View {
        Menu {
            Picker("Select an option", selection: $selectedOption) {
                ForEach(0 ..< options.count) { index in
                    Text(options[index]).tag(index)
                }
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.UIButtonGreen)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.05)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.UIButtonGreen.opacity(0.5), lineWidth: 1)
                    )

                Text(options[selectedOption])
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.white)
            }
        }
    }
}

#Preview {
    FilterQuizItemUI(filterSelected: .constant(.filterDefault), filterSelectedOption: .constant(0), action: {})
}
