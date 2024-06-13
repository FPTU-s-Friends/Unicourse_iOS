//
//  DailyRewardWeekCard.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/6/24.
//

import SwiftUI

enum StatusDate {
    case past
    case today
    case future
}

struct StatusCoinByDate {
    let title: String
    let statusDate: StatusDate
    let urlIcon: String
    let colorText: Color
    let colorBackgroundCoin: Color
    let colorBackgrounText: Color
}

struct DailyRewardWeekCard: View {
    var listDailyReward: [DailyRewardModel]
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
                    ForEach(listDailyReward) { date in
                        let comparisonResult = compareDates(date.day, todayDate: todayDateString)
                        let isClaimedCoin = date.list_users.contains(user_id)

                        let displayStatusDate = switch comparisonResult {
                        case 0: // Hôm nay
                            StatusCoinByDate(
                                title: isClaimedCoin ? "Đã nhận" : "Hôm nay",
                                statusDate: .today,
                                urlIcon: "enableDollar",
                                colorText: isClaimedCoin ? Color.colorTextDailyCoinClaimed : Color.colorTextDailyCoinNormal,
                                colorBackgroundCoin: isClaimedCoin ? Color.colorBackgroundCardCoinClaimed : Color.colorBackgroundCardCoinNormal,
                                colorBackgrounText: isClaimedCoin ? Color.colorBackgroundTextCoinClaimed : Color.colorBackgroundTextCoinNormal)
                        case 1: // Quá khứ
                            StatusCoinByDate(
                                title: isClaimedCoin ? "Đã nhận" : "Hết hạn",
                                statusDate: .past,
                                urlIcon: isClaimedCoin ? "enableDollar" : "disableDollar",
                                colorText: isClaimedCoin ? Color.colorTextDailyCoinClaimed : Color.colorTextDailyCoinMissed,
                                colorBackgroundCoin: isClaimedCoin ? Color.colorBackgroundCardCoinClaimed : Color.colorBackgroundCardCoinMissed,
                                colorBackgrounText: isClaimedCoin ? Color.colorBackgroundTextCoinClaimed : Color.colorBackgroundTextCoinMissed)
                        case 2: // Tương lai
                            StatusCoinByDate(
                                title: getVietnameseDayOfWeek(for: date.day) ?? "",
                                statusDate: .past,
                                urlIcon: "enableDollar",
                                colorText: Color.colorTextDailyCoinNormal,
                                colorBackgroundCoin: Color.colorBackgroundCardCoinNormal,
                                colorBackgrounText: Color.colorBackgroundTextCoinNormal)
                        default:
                            StatusCoinByDate(
                                title: isClaimedCoin ? "Đã nhận" : "Hết hạn",
                                statusDate: .past,
                                urlIcon: isClaimedCoin ? "enableDollar" : "disableDollar",
                                colorText: Color.colorTextDailyCoinNormal,
                                colorBackgroundCoin: Color.colorBackgroundCardCoinNormal,
                                colorBackgrounText: Color.colorBackgroundTextCoinNormal)
                        }

                        VStack(alignment: .center, spacing: 0) {
                            Text("+ 100")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(displayStatusDate.colorText)
                                .padding(.horizontal, 23)
                            Image(displayStatusDate.urlIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.horizontal, 23)
                                .padding(.vertical, 10)
                            Text(displayStatusDate.title)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(displayStatusDate.colorText)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 5)
                                .background(displayStatusDate.colorBackgrounText)
                        }
                        .padding(.top, 10)
                        .background(displayStatusDate.colorBackgroundCoin)
                        .cornerRadius(10)
                    }
                }
                .padding(.trailing, 15)
            }
            .padding(.leading, 15)

            Spacer()
        }
    }
}

struct DailyRewardWeekCardPreview: PreviewProvider {
    static var previews: some View {
        DailyRewardWeekCard(listDailyReward: DailyRewardModel.mockData, todayDateString: "2024-06-13T10:27:00.021Z", user_id: "6646f84216457d365c09d6d6")
    }
}
