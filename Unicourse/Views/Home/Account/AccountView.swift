//
//  AccountView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 7/5/24.
//

import SwiftUI

struct AccountView: View {
    @StateObject var viewModel = AccountViewModel()
    @EnvironmentObject var appData: AppData

    var body: some View {
        ZStack {
            VStack {
                HeaderAccountView()
                    .padding(.trailing, 10)
                ScrollView {
                    VStack {
                        UserStatisticView()

                        AccountMenuView(menuItems: viewModel.menuItems)
                            .padding(.bottom, 30)
                    }
                    .background {
                        Color.white
                            .frame(width: 360, height: 550)
                            .cornerRadius(20)
                            .offset(y: 20)
                    }
                }
            }
            LoadingIndicatorView(isLoading: $appData.isLoading)
        }
        .background {
            LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        AccountView()
            .environmentObject(AppData())
    }
}
