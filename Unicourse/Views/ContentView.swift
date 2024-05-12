//
//  ContentView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/5/24.
//

import Firebase
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @EnvironmentObject var appData: AppData

    var body: some View {
        ZStack {
            NavigationView {
                if viewModel.isLoggedIn {
                    MainHomeView()
                } else {
                    OnBoardView()
                }
            }
            .onAppear {
                Task {
                    try await checkUserAuthentication()
                }
            }
        }
    }

    // Kiểm tra trạng thái đăng nhập của người dùng
    func checkUserAuthentication() async throws {
        if let email = Auth.auth().currentUser?.email {
            viewModel.isLoggedIn = true
            NetworkManager.shared.signIn(email: email) { result in
                switch result {
                    case let .success(data):
                        let accessToken = data.data.accessToken.split(separator: " ")[1]
                        appData.token = String(accessToken)
                        appData.decodeJWTTokenAndSetUserProfile(token: String(accessToken))
                    case let .failure(error):
                        appData.isShowingAlert = true
                        appData.error = error.localizedDescription
                }
            }
        } else {
            appData.isShowingAlert = true
            appData.error = "User is not Sign in"
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppData())
}
