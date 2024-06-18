//
//  CartProductItem.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct CartProductItem: View {
    @Binding var isChecked: Bool
    var item: CartItem

    var body: some View {
        HStack {
            ButtonCheckBox(isChecked: $isChecked)

            NavigationLink(destination: CourseDetailView(courseId: item._id)) {
                HStack {
                    AsyncImage(url: URL(string: item.thumbnail)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.3, height: 75)
                            .cornerRadius(10)
                    } placeholder: {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width * 0.3, height: 75)
                            .cornerRadius(10)
                            .shimmerWithWave()
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text(item.title)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 14, weight: .semibold))
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
    }
}

#Preview {
    CartProductItem(isChecked: .constant(true), item: .sampleData)
}
