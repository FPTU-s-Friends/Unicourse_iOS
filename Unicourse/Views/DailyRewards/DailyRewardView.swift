//
//  DailyRewardView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 3/6/24.
//
import SDWebImageSwiftUI
import SwiftUI

struct DailyRewardView: View {
    @Binding var openToggle: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color(hex: "#d3eac8"), Color(hex: "#4c8435")],
                        startPoint: .top,
                        endPoint: .center
                    )
                )
                .ignoresSafeArea()

            VStack(spacing: 15) {
                HStack {
                    Spacer()
                    Button(action: {
                        openToggle.toggle()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 25))
                            .foregroundStyle(.white)
                    })
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Săn Điểm Thưởng,")
                            .foregroundStyle(.white)
                        Text("Thêm Tiết Kiệm")
                            .foregroundStyle(Color(hex: "#13250e"))
                    }
                    .font(.system(size: 28, weight: .bold))

                    Image(.bagcoin)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
                .padding(.horizontal, 20)

                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, maxHeight: 200)
                    .foregroundStyle(.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .overlay(content: {
                        DailyRewardInsideCard()
                    })
                    .padding(.horizontal, 15)

                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .overlay(content: {
                        DailyRewardWeekCard()
                    })
                    .ignoresSafeArea(.all, edges: .bottom)

                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DailyRewardView(openToggle: .constant(true))
}
