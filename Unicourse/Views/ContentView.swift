//
//  ContentView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/5/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var socketIOManager: SocketIOManager
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        ZStack {
            NavigationStack {
                if appData.isLoggedIn {
                    CustomHomeView()
                } else {
                    OnBoardView()
                }
            }
        }
        .onAppear {
            Task {
                do {
                    guard appData.isLoggedIn else { return }
                    guard let userId = appData.user?.userId else { return }
                    try await appData.getUserInfo(userId: userId, token: appData.token)
                } catch {
                    print(error)
                }
            }
        }
        .onAppear {}
    }
}

#Preview {
    ContentView()
        .environmentObject(AppData())
}
