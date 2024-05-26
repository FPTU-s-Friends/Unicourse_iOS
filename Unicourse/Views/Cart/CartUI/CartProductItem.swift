//
//  CartProductItem.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct CartProductItem: View {
    @Binding var isChecked: Bool
    @Binding var isCheckedAllItemPerson: Bool

    var body: some View {
        HStack {
            ButtonCheckBox(isChecked: $isChecked)

            NavigationLink(destination: CourseDetailView(courseId: "65a8790ba30979a347d026c9")) {
                HStack {
                    Image("3diconsiconcourse")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                        .cornerRadius(10)
                    VStack(alignment: .leading) {
                        Text("Thiết kế và tạo mẫu với Figma: Từ người mới bắt đầu đến chuyên nghiệp")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 12, weight: .light))
                            .foregroundStyle(.black)
                        // ---
                        HStack {
                            Text("50.000 VND")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.activeColor)
                            // ---
                            Text("70.000 VND")
                                .font(.system(size: 12, weight: .bold))
                                .strikethrough()
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .onChange(of: isCheckedAllItemPerson) {
            withAnimation {
                isChecked = isCheckedAllItemPerson
            }
        }
        .onChange(of: isChecked) {
            withAnimation {
                if isChecked == false {
                    isCheckedAllItemPerson = false
                }
            }
        }
    }
}

#Preview {
    CartProductItem(isChecked: .constant(true), isCheckedAllItemPerson: .constant(false))
}
