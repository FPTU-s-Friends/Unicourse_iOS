//
//  PlashScreenView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct SlashScreenView: View {
    var body: some View {
        ZStack {
//            LinearGradient(colors: [Color.mainColor1, .white], startPoint: .leading, endPoint: .bottomLeading)
//                .ignoresSafeArea()

//            LoadingIndicatorView(isLoading: .constant(true))
//                .padding(.top, 400)

            Image("mainIconApp")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .padding(.bottom, 50)
        }
    }
}

#Preview {
    SlashScreenView()
}
