//
//  DailyRewardInsideCard.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/6/24.
//

import SwiftUI

struct DailyRewardInsideCard: View {
    let totalCoin: Int
    let user_id: String
    let daily_id: String
    let token: String
    let todayDateString: String
    let isCoinClaimed: (_ date: String, _ userId: String) -> Bool
    let claimCoinToday: (_ daily_id: String, _ token: String) -> Void

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Thưởng của bạn")
                    .font(.system(size: 16, weight: .semibold))
                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .semibold))
                Spacer()
            }

            HStack(alignment: .center) {
                HStack {
                    Text("\(totalCoin)")
                        .font(.system(size: 45, weight: .semibold))
                        .foregroundStyle(Color(hex: "#064e3b"))
                    Image(.enableDollar)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .offset(y: 5)
                }
                Spacer()
                if isCoinClaimed(todayDateString, user_id) == true {
                    Button(action: {
                        print(getCurrentDateAsISOString())
                    }, label: {
                        VStack {
                            Text("Đã nhận rồi")
                                .fontWeight(.semibold)
                        }
                        .padding(.vertical, 7)
                        .padding(.horizontal, 15)
                        .foregroundStyle(.white)
                        .background(Color(hex: "#d6d3d1"))
                        .cornerRadius(16)
                    }).disabled(true)
                } else {
                    Button(action: {
                        claimCoinToday(daily_id, token)
                    }, label: {
                        VStack {
                            Text("Nhận point ngay")
                                .fontWeight(.semibold)
                        }
                        .padding(.vertical, 7)
                        .padding(.horizontal, 15)
                        .foregroundStyle(.white)
                        .background(Color(hex: "#047857"))
                        .cornerRadius(16)
                    })
                }
            }
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

            VStack(alignment: .leading) {
                Text("Thưởng 100 point sẽ hết hạn vào cuối ngày hôm nay")
                Text("Nếu chưa nhận point, hãy nhanh tay nhận ngay bạn nhé")
            }
            .font(.system(size: 12, weight: .regular))
            .padding(.vertical, 3)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/)

            Spacer()
        }
        .padding(20)
    }
}

// #Preview {
//    DailyRewardInsideCard(totalCoin: 222, user_id: "", todayDateString: "") { _, _ in
//        printJSONData(data: "")
//    }
// }
