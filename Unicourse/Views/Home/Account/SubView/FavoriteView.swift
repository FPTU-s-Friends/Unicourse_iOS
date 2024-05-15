//
//  FavoriteView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct FavoriteView: View {
    @State var searchString: String = ""
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.blue)
                            TextField("", text: $searchString)
                                .font(Font.custom("SF Pro Display", size: 14))
                                .lineSpacing(20)
                                .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.76))
                                .padding(.horizontal, 4)
                                .padding(.vertical, 8)
                        }
                        .padding(12)
                        .frame(height: 44)
                        .background(.white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.25)
                                .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 0.25)
                        )
                    }
                }
                .padding(EdgeInsets(top: 6, leading: 18, bottom: 6, trailing: 18))
                .frame(width: 375, height: 56)
                .padding(.horizontal, 10)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 5)], spacing: 10) {
                    ForEach(0 ..< 4) { _ in
                        ZStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                VStack {
                                    Image("courseImageEx")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                                .frame(width: 190)
                                .padding(.top, 10)

                                Text("WDU203c - The UI/UX Design")
                                    .font(.system(size: 14, weight: .bold))
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
                                    .frame(width: 10)
                                    .foregroundColor(.yellow)

                                Image(systemName: "star.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10)
                                    .foregroundColor(.yellow)

                                Image(systemName: "star.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10)
                                    .foregroundColor(.yellow)

                                Image(systemName: "star.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10)
                                    .foregroundColor(.yellow)

                                Image(systemName: "star.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10)
                                    .foregroundColor(.yellow)
                            }
                            .padding(2)
                            .background(Color(red: 1, green: 1, blue: 1).opacity(0.50))
                            .cornerRadius(5)
                            .padding(.horizontal, 5)
                            .offset(x: -50, y: 175)
                        }
                        .frame(width: 180, height: 260)
                        .background(.white)
                        .cornerRadius(12)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        FavoriteView()
    }
}
