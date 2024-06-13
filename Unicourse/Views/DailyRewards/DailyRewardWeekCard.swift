//
//  DailyRewardWeekCard.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/6/24.
//

import SwiftUI

struct DailyRewardWeekCard: View {
    var listDaily: [DailyRewardModel]
    var todayDateString: String
    var user_id: String

    var body: some View {
        VStack {
            HStack {
                Text("Phần thưởng hằng ngày")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Button(action: {}, label: {
                    HStack(spacing: 5) {
                        Image(systemName: "bell.and.waves.left.and.right.fill")
                        Text("Nhắc tôi")
                    }
                    .foregroundStyle(Color(hex: "#713f12"))
                    .font(.system(size: 13))
                    .padding(.horizontal, 5)
                    .padding(.vertical, 3)
                    .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color(hex: "#fef3c7")))
                })
            }
            .padding(20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(listDaily, id: \._id) { date in
                        let isTodayCoin = areDatesEqualIgnoringTime(date.day, todayDateString)
                        let isEnrolledCoinToday = date.list_users.contains(user_id)

                        VStack(alignment: .center, spacing: 0) {
                            Text("+ 100")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color.colorTextDailyCoin)
                                .padding(.horizontal, 23)
                            Image(isEnrolledCoinToday ? .disableDollar : .enableDollar)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.horizontal, 23)
                                .padding(.vertical, 10)
                            Text(isEnrolledCoinToday ? "Đã nhận" : (isTodayCoin ? "Hôm nay" : getVietnameseDayOfWeek(for: date.day)) ?? "")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color.colorTextDailyCoin)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 5)
                                .background(Color.colorBackgroundTextDailyCoin)
                        }
                        .padding(.top, 10)
                        .background(isEnrolledCoinToday ? Color.colorBackgroundCardCoin : Color.colorAlreadyGetCoin)
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.leading, 15)

            Spacer()
        }
    
    }
}

#Preview {
    DailyRewardWeekCard(listDaily: DailyRewardModel.mockData, todayDateString: "2024-06-10T10:27:00.021Z", user_id: "6646f84216457d365c09d6d6")
}
