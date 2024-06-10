//
//  HeaderUserView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import SwiftUI

struct HeaderUserView: View {
    @EnvironmentObject var appData: AppData

    var body: some View {
        HStack {
            VStack {
                if let profileImageURL = appData.user?.profileImageURL,
                   let url = URL(string: profileImageURL.absoluteString)
                {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                            .cornerRadius(30)
                    } placeholder: {
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .cornerRadius(30)
                            .shimmerWithWave()
                    }
                } else {
                    Image(.user)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                        .cornerRadius(30)
                }
            }
            VStack(alignment: .leading, spacing: 7) {
                Text("\(appData.user?.fullName ?? "Loading...")")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)

                if let userRole = appData.user?.role {
                    switch userRole {
                    case .student:
                        roleText(TextRole.student)
                    case .lecture:
                        roleText(TextRole.lecture)
                    case .admin:
                        roleText(TextRole.admin)
                    }
                } else {
                    roleText(TextRole.defaultValue)
                }
            }
        }
    }

    func roleText(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 12, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Capsule()
                    .fill(Color.UIButtonGreen)
            )
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    HeaderUserView()
        .environmentObject(AppData())
}
