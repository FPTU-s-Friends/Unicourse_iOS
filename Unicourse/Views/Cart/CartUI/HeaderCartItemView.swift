//
//  HeaderCartItemview.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct HeaderCartItemView: View {
    @Binding var name: String
    @Binding var isCheckedAll: Bool
    @Binding var isCheckedAllItemPerson: Bool

    var body: some View {
        HStack {
            Image("User")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)

            Text(name)
                .font(.system(size: 12, weight: .light))
                .foregroundStyle(.gray)

            Spacer()

            Button(action: {}, label: {
                Image(systemName: "pencil.line")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14)
                    .foregroundStyle(Color.accentColor)
                    .padding(8)
                    .background(Color.grayItem.cornerRadius(10))
            })

            Button(action: {
                isCheckedAllItemPerson.toggle()
            }, label: {
                Text(isCheckedAllItemPerson ? "Bỏ chọn" : "Chọn tất cả")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color.accentColor)
                    .padding(8)
                    .background(Color.grayItem.cornerRadius(10))
            })
        }
        .onChange(of: isCheckedAll) { _, _ in
            // nếu mà checkAll tất cả item thì thằng này cũng trở thành true
            isCheckedAllItemPerson = isCheckedAll
        }
        .onChange(of: isCheckedAllItemPerson) { _, newValue in
            // ở đây phòng trường hợp người dùng CheckAll thành true trước, xong nhấn bỏ chọn thì chuyển checkAll thành false
            if newValue == false {
                isCheckedAll = isCheckedAllItemPerson
            }
        }
    }
}

#Preview {
    HeaderCartItemView(name: .constant("Nguyễn Trung Kiên"), isCheckedAll: .constant(false), isCheckedAllItemPerson: .constant(false))
}
