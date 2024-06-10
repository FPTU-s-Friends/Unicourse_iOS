//
//  DailyRewardWeekCard.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/6/24.
//

import SwiftUI

struct DailyRewardWeekCard: View {
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

//            ScrollView {
//                HStack {
//
//                }
//            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0 ..< 7) { _ in
                        VStack(alignment: .center, spacing: 0) {
                            Text("+ 100")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(hex: "#713f12"))
                                .padding(.horizontal, 23)
                            Image(.enableDollar)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.horizontal, 23)
                                .padding(.vertical, 10)
                            Text("Hôm nay")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(hex: "#713f12"))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 5)
                                .background(Color(hex: "#fde68a"))
                        }
                        .padding(.top, 10)
                        .background(Color(hex: "#fef3c7"))
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
    DailyRewardWeekCard()
}
