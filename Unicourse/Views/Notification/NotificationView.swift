//
//  NotificationView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 18/5/24.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        VStack {
            HStack {
                Text("Tất cả")
                    .font(.system(size: 14, weight: .light))
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .foregroundStyle(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.mainColor1, lineWidth: 0.5)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.mainColor1)
                    )

                Text("Khoá học")
                    .font(.system(size: 14, weight: .light))
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .foregroundStyle(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 0.5)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                    )

                Text("Giảng viên")
                    .font(.system(size: 14, weight: .light))
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .foregroundStyle(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 0.5)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                    )

                Spacer()

                Button(action: {}, label: {
                    HStack(spacing: 8) {
                        Image("filterIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14)
                    }
                    .padding(8)
                    .background(.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.25)
                            .stroke(Color.activeColor, lineWidth: 1)
                    )
                })
            }
            .padding(.horizontal, 10)

            ScrollView {
                NotificationItemView(title: "Hôm nay")

                NotificationItemView(title: "Hôm qua")
            }
            .padding()
            .background(Color.mainBackgroundColor)

            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                }
            }
        }
        .navigationTitle("Thông báo")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        NotificationView()
    }
}
