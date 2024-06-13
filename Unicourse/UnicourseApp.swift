//
//  UnicourseApp.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/5/24.
//

import SwiftUI

@main
struct UnicourseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appData = AppData()
    @State private var isNavigateToLoginView = false

    var body: some Scene {
        WindowGroup {
            VStack {
                if appData.isShowSlashScreen {
                    SlashScreenView()
                } else {
                    ContentView()
                        .environmentObject(appData)
                        .environmentObject(SocketIOManager.shared)
                        .alert("Error", isPresented: $appData.isShowingAlert) {
                            Button("OK", role: .cancel) {
                                appData.isShowingAlert = false
                            }
                        } message: {
                            Text(appData.error)
                        }
                }
            }

            .preferredColorScheme(.light)
            .animation(.spring(), value: appData.isShowSlashScreen)
            .onAppear {
                Task {
                    do {
                        try await appData.checkUserAuthentication()
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                        appData.isShowSlashScreen = false
                    } catch {
                        print("Authentication error: \(error)")
                        appData.isShowSlashScreen = false
                    }
                }
            }
        }
    }
}
