//
//  ResultUserView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 10/5/24.
//

import SwiftUI

struct ResultUserView: View {
    var body: some View {
        //        User Find
        HStack {
            Image("User")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)

            VStack(alignment: .leading) {
                VStack {
                    Text("Nguyễn Trung Kiên")
                        .font(.system(size: 12, weight: .bold))
                }

                HStack(spacing: 3) {
                    ForEach(0 ..< 5) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 8)
                            .foregroundColor(.yellow)
                    }

                    Text("12 Courses")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(.gray)
                        .padding(.leading, 5)
                }
            }

            Spacer()

            Button(action: {}, label: {
                Image(systemName: "ellipsis.message")
                    .font(.system(size: 18))
                    .padding(8)
                    .foregroundColor(.blue)
                    .background(Color.mainBackgroundColor)
                    .clipShape(Rectangle())
                    .cornerRadius(10)
                    .overlay(
                        Rectangle()
                            .stroke(Color.gray, lineWidth: 0.1)
                            .cornerRadius(10)
                    )
            })

            Button(action: {}, label: {
                HStack(spacing: 10) {
                    Text("Xem")
                        .font(.system(size: 12, weight: .bold))
                        .lineSpacing(20)
                        .foregroundColor(Color(red: 0.93, green: 0.93, blue: 0.93))
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .frame(width: 100, height: 35)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.mainColor1, .mainColor2]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(7)
            })
        }
        .padding()
    }
}

#Preview {
    ResultUserView()
}
