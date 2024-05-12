//
//  SuggessCourseView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 10/5/24.
//

import SwiftUI

struct SuggestCourseView: View {
    var body: some View {
        //                Suggest Course

        HStack {
            Text("Suggest Search")
                .font(.system(size: 12))
                .lineSpacing(20)
                .foregroundColor(Color(red: 0.55, green: 0.54, blue: 0.54))

            Spacer()

            Button(action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/, label: {
                Image("reloadIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
            })
        }
        .padding(.horizontal, 10)
        Spacer()
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 20)], spacing: 60) {
                ForEach(0 ..< 20) { _ in
                    GeometryReader { geometry in
                        HStack(spacing: 10) {
                            Image("3dicons")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .padding(10)
                                .cornerRadius(7)

                            Text("MAD101 - Toán rời rạc")
                                .font(.system(size: 12))
                        }
                        .frame(maxWidth: geometry.size.width)
                        .background(.white)
                        .cornerRadius(12)
                    }
                }
            }
        }
    }
}

#Preview {
    SuggestCourseView()
}
