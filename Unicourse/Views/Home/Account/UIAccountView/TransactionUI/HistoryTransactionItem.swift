//
//  HistoryTransactionItem.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 16/5/24.
//

import SwiftUI

struct HistoryTransactionItem: View {
    @State private var isShowDetailHistory: Bool = false

    // để lấy example ở đây th, mốt đổi thành đối tượng
    var name: String
    //

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Image("User")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)

                    Text(name)
                        .font(.system(size: 12, weight: .light))
                        .foregroundStyle(.gray)
                }

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

                if isShowDetailHistory {
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

                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Mar 12 - 2024")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.gray)

                        Text("2 Khoá học")
                            .font(.system(size: 14, weight: .bold))
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 8) {
                        Text("Tổng giá")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.gray)

                        Text("90.000 VND")
                            .font(.system(size: 16, weight: .bold))
                            .lineSpacing(20)
                            .foregroundColor(.activeColor)
                    }
                }
            }
            .padding(30)

            Button(action: {
                withAnimation {
                    isShowDetailHistory.toggle()
                }
            }, label: {
                Text(isShowDetailHistory ? "Thu gọn" : "Xem thêm")
                    .font(.system(size: .mainTitleButtonPath))
                    .foregroundStyle(.white)
                    .padding(6)
                    .padding(.horizontal, 10)
                    .background(Color.activeButtonColor.cornerRadius(20))
            })
        }
    }
}

#Preview {
    HistoryTransactionItem(name: "Nguyễn Trung Kiên")
}
