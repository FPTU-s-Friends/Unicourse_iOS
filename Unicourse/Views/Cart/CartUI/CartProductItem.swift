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
    var item: CartItem

    var body: some View {
        HStack {
            ButtonCheckBox(isChecked: $isChecked)

            NavigationLink(destination: CourseDetailView(courseId: "65a8790ba30979a347d026c9")) {
                HStack {
                    AsyncImage(url: URL(string: item.thumbnail)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.2, height: 60)
                            .cornerRadius(10)
                    } placeholder: {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width * 0.2, height: 60)
                            .cornerRadius(10)
                            .shimmerWithWave()
                    }

                    VStack(alignment: .leading) {
                        Text("Thiết kế và tạo mẫu với Figma: Từ người mới bắt đầu đến chuyên nghiệp")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 12, weight: .light))
                            .foregroundStyle(.black)
                        // ---
                        HStack {
                            Text("\(item.amount) VND")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.activeColor)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                            // ---
                            Text("\(item.amount + 20000) VND")
                                .font(.system(size: 12, weight: .bold))
                                .strikethrough()
                                .foregroundColor(.gray)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
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
    CartProductItem(isChecked: .constant(true), isCheckedAllItemPerson: .constant(false), item: .sampleData)
}
