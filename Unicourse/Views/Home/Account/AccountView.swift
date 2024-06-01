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
            LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom)
                .ignoresSafeArea()

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
                            .cornerRadius(20)
                            .offset(y: 30)
                    }
                    .padding(.horizontal, 30)
                }
            }

            if appData.isLoading {
                LoadingIndicatorView(isLoading: .constant(true))
            }
        }
    }
}

#Preview {
    NavigationStack {
        AccountView()
            .environmentObject(AppData())
    }
}
