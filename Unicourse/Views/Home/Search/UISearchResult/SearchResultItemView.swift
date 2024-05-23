//
//  SearchResultItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SwiftUI

struct SearchResultItemView: View {
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                VStack {
                    Image("courseImageEx")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 190)
                .padding(.top, 10)

                VStack {
                    HStack {
                        Image("User")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)

                        Text("Đinh Gia Bảo")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal, 15)

                Text("WDU203c - The UI/UX Design")
                    .font(.system(size: 12))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .padding(.horizontal, 15)

                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("229.000 vnđ")
                        .font(.system(size: 12, weight: .bold))
                        .lineSpacing(20)
                        .foregroundColor(.mainColor1)
                    Text("339.000 vnđ")
                        .font(.system(size: 10))
                        .lineSpacing(20)
                        .strikethrough()
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            }

            HStack(alignment: .top, spacing: 4) {
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 8)
                    .foregroundColor(.yellow)

                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 8)
                    .foregroundColor(.yellow)

                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 8)
                    .foregroundColor(.yellow)

                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 8)
                    .foregroundColor(.yellow)

                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 8)
                    .foregroundColor(.yellow)
            }
            .padding(2)
            .background(Color(red: 1, green: 1, blue: 1).opacity(0.50))
            .cornerRadius(5)
            .padding(.horizontal, 5)
            .offset(x: -40, y: 160)
        }
        .frame(width: 180, height: 260)
        .background(.white)
        .cornerRadius(12)
    }
}

#Preview {
    SearchResultItemView()
}
