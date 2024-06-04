//
//  PageView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/5/24.
//

import SwiftUI

struct PageView: View {
    var page: OnboardModel

    var body: some View {
        VStack(spacing: 10) {
            if page.tag == 2 {
                Image("\(page.imageUrl)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width, height: 750)
                    .cornerRadius(10)
                    .padding(.bottom, -220)
                    .padding(.top, 30)
                    .padding(.leading, 2)
            } else {
                Image("\(page.imageUrl)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width, height: 570)
                    .cornerRadius(10)
            }

            Text(page.name)
                .font(.system(size: 32, weight: .bold, design: .default))
                .foregroundColor(.black)

            Text(page.description)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 300, height: 60)
                .foregroundColor(.gray)
                .padding(.bottom, 10)

            Spacer()
        }
    }
}

#Preview {
    PageView(page: OnboardModel.pageBanners[0])
}
