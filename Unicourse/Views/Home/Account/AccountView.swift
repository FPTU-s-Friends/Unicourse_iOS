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
                HeaderAccountView(isPresentedEditSheet: $viewModel.isPresentedEditSheet,
                                  isPresentedSettingSheet: $viewModel.isPresentedSettingSheet)
                    .padding(.trailing, 10)
                    .padding(.top, 20)

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
            .sheet(isPresented: $viewModel.isPresentedEditSheet, content: {
                NavigationView {
                    EditSheetView()
                        .navigationTitle("Thông tin")
                        .navigationBarTitleDisplayMode(.large)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(action: {
                                    withAnimation {
                                        viewModel.isPresentedEditSheet = false
                                    }
                                }, label: {
                                    HStack {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20)
                                            .foregroundStyle(Color.gray)
                                    }
                                })
                            }
                        }
                }
                .presentationDetents([.large])

            })
            .sheet(isPresented: $viewModel.isPresentedSettingSheet, content: {
                NavigationView {
                    SettingSheetView()
                        .navigationTitle("Cài đặt ⚙️")
                        .navigationBarTitleDisplayMode(.large)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(action: {
                                    withAnimation {
                                        viewModel.isPresentedSettingSheet = false
                                    }
                                }, label: {
                                    HStack {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20)
                                            .foregroundStyle(Color.gray)
                                    }
                                })
                            }
                        }
                }
                .presentationDetents([.large])

            })

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
