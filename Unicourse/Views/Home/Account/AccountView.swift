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
                .edgesIgnoringSafeArea(.top)
            
            Color.white
                .frame(width: 360, height: 600)
                .cornerRadius(20)
                .offset(y: 30)
                .edgesIgnoringSafeArea(.top)
            
            Color.white
                .frame(width: 360, height: 600)
                .cornerRadius(20)
                .offset(y: 30)
            
            VStack {
                HeaderAccountView()
                
                VStack(spacing: 20) {
                    UserStatisticView()
                    
                    AccountMenuView(menuItems: $viewModel.menuItems)
                    HeaderAccountView()
                    
                    VStack(spacing: 20) {
                        UserStatisticView()
                        
                        AccountMenuView(menuItems: $viewModel.menuItems)
                    }
                    .frame(width: 400, height: 600)
                    Spacer()
                }
                .offset(y: -30)
                
                //            LoadingIndicatorView(isLoading: $appData.isLoading)
                //                .opacity(1)
                //                .animation(.easeInOut(duration: 0.5), value: appData.isLoading)
                
                // loading o day van chua duoc
            }
        }
    }
}

#Preview {
    NavigationStack {
        AccountView()
    }
}
