//
//  UserStatiticView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct UserStatisticView: View {
    @EnvironmentObject var appData: AppData

    var body: some View {
        AsyncImage(url: URL(string: appData.user?.profileImageURL?.absoluteString ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(60)

        } placeholder: {
            RoundedRectangle(cornerRadius: 60)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 100, height: 100)
                .shimmerWithWave()
        }
        Text(appData.user?.fullName ?? "Người dùng Unicourse")
            .font(.system(size: 16, weight: .bold))

        HStack(spacing: 50) {
            VStack(spacing: 15) {
                Image(systemName: "clock")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.blue)

                Text("Tiến trình")
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(.gray)

                Text("68 Giờ")
                    .font(.system(size: 14, weight: .bold))
            }

            VStack(spacing: 15) {
                Image(systemName: "rosette")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.yellow)

                Text("Hoàn Thành")
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(.gray)

                Text("84%")
                    .font(.system(size: 14, weight: .bold))
            }

            VStack(spacing: 15) {
                Image(systemName: "book")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.blue)

                Text("Tiến trình")
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(.gray)

                Text("\(appData.userInfo?.enrollCourses?.count ?? 0) Khoá")
                    .font(.system(size: 14, weight: .bold))
            }
        }
        .padding(15)
        .background(.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

#Preview {
    UserStatisticView()
        .environmentObject(AppData())
}
