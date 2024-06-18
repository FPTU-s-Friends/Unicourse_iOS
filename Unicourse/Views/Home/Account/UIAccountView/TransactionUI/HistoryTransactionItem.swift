//
//  HistoryTransactionItem.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 16/5/24.
//

import SwiftUI

struct HistoryTransactionItem: View {
    @State private var isShowDetailHistory: Bool = false
    var transactionHistory: TransactionHistoryModel

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    AsyncImage(url: URL(string: transactionHistory.userId.profile_image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .cornerRadius(20)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 30, height: 30)
                            .shimmerWithWave()
                    }

                    Text(transactionHistory.userId.fullName)
                        .font(.system(size: 12, weight: .light))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .foregroundStyle(.gray)

                    Spacer()

                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isShowDetailHistory.toggle()
                        }
                    }, label: {
                        Text(isShowDetailHistory ? "Thu gọn" : "Xem thêm")
                            .font(.system(size: .mainTitleButtonPath))
                            .foregroundStyle(.white)
                            .padding(6)
                            .padding(.horizontal, 10)
                            .background(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                    })
                }

                ForEach(transactionHistory.items_checkout.prefix(isShowDetailHistory ? transactionHistory.items_checkout.count : 1), id: \._id) { item in
                    HStack {
                        AsyncImage(url: URL(string: item.thumbnail)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 60)
                                .cornerRadius(10)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 80, height: 60)
                                .shimmerWithWave()
                        }

                        VStack(alignment: .leading) {
                            Text(item.title)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                .font(.system(size: 12, weight: .light))
                            // ---
                            HStack {
                                Text("\(item.amount) VND")
                                    .font(.system(size: 14, weight: .bold))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                    .foregroundColor(.activeColor)
                                // ---
                                Text("\(item.amount + 20000) VND")
                                    .font(.system(size: 12, weight: .bold))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                    .strikethrough()
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }

                if isShowDetailHistory {
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                        Text("Chi tiết")
                            .font(.system(size: 12, weight: .light))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Giá sản phẩm ước lượng: ")
                                .font(.system(size: 13, weight: .semibold))

                            Text("Tổng xu đã sử dụng: ")
                                .font(.system(size: 13, weight: .semibold))

                            Text("Hình thức thanh toán")
                                .font(.system(size: 13, weight: .semibold))
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 8) {
                            Text("\(transactionHistory.total_old_amount) VND")
                                .font(.system(size: 13, weight: .light))
                                .foregroundStyle(.gray)

                            Text("\(transactionHistory.total_used_coin)")
                                .font(.system(size: 13, weight: .light))
                                .foregroundStyle(.gray)

                            Text("\(transactionHistory.payment_method)")
                                .font(.system(size: 13, weight: .light))
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(Color.UIButtonGreen.cornerRadius(10))
                                .foregroundStyle(.white)
                        }
                    }
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                        Text("Tổng số")
                            .font(.system(size: 12, weight: .light))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                }

                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(convertDateToString(dateString: transactionHistory.process_date))
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.gray)

                        Text("\(transactionHistory.items_checkout.count) Khoá học")
                            .font(.system(size: 14, weight: .bold))
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 8) {
                        Text("Tổng giá")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.gray)

                        Text("\(transactionHistory.total_new_amount) VND")
                            .font(.system(size: 16, weight: .bold))
                            .lineSpacing(20)
                            .foregroundColor(.activeColor)
                    }
                }
            }
            .padding(30)
            .background(Color.white.cornerRadius(10))
        }
        .padding(.horizontal, 15)
    }

    func convertDateToString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ" // Adjust this format if needed based on your date string
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid date format" // Handle invalid date string
        }

        dateFormatter.dateFormat = "MMM d - yyyy" // Output format
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

#Preview {
    HistoryTransactionItem(transactionHistory: .sampleTransactionHistory)
}
