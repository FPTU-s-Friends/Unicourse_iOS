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
        ScrollView {
            ZStack {
                Color.white
                    .frame(width: 360, height: 600)
                    .cornerRadius(20)
                    .offset(y: 60)
                
                VStack {
                    HeaderAccountView()
                    
                    VStack(spacing: 20) {
                        UserStatisticView()
                            
                        AccountMenuView(menuItems: $viewModel.menuItems)
                    }
                    .frame(width: 400, height: 600)
                    Spacer()
                }
                .offset(y: 0)
                
                LoadingIndicatorView(isLoading: $appData.isLoading)
            }
        }
        .background(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom)
            .edgesIgnoringSafeArea(.top))
    }
}

#Preview {
    NavigationStack {
        AccountView()
    }
}
