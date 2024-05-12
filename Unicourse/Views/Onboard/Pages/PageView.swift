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
            Image("\(page.imageUrl)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: 550)
                .cornerRadius(20)

            Text(page.name)
                .font(.system(size: 32, weight: .bold, design: .default))
                .foregroundColor(.black)

            Text(page.description)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .frame(width: 300)
                .foregroundColor(.gray)
                .padding(.bottom, 10)

            Spacer()
        }
    }
}

#Preview {
    PageView(page: OnboardModel.pageBanners[2])
}
