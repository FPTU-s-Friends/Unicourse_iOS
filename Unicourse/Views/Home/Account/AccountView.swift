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
    @State private var isNavigateToDashboard = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                HeaderAccountView(isPresentedEditSheet: $viewModel.isPresentedEditSheet, isNavigateToSettingView: $viewModel.isNavigateToSettingView)
                    .padding(.trailing, 10)
                    .padding(.top, 20)

                ScrollView {
                    VStack {
                        UserStatisticView()
                            .onTapGesture {
                                withAnimation {
                                    isNavigateToDashboard = true
                                }
                            }

                        AccountMenuView(menuItems: viewModel.menuItems)
                    }
                    .background {
                        Color.white
                            .cornerRadius(20)
                            .offset(y: 30)
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.bottom, 60)
            }

            .navigationDestination(isPresented: $viewModel.isNavigateToSettingView, destination: {
                SettingSheetView()
                    .navigationBarBackButtonHidden(true)

            })

            .sheet(isPresented: $viewModel.isPresentedEditSheet, content: {
                EditSheetView(isPresentEditSheet: $viewModel.isPresentedEditSheet)
                    .presentationDetents([.large])
                    .interactiveDismissDisabled()

            })

            if appData.isLoading {
                LoadingIndicatorView(isLoading: .constant(true))
            }
        }
        .navigationDestination(isPresented: $isNavigateToDashboard) {
            DashboardView()
                .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        AccountView()
            .environmentObject(AppData())
    }
}
