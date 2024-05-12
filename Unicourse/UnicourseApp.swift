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
    @StateObject var appData = AppData() // Use @StateObject instead of @EnvironmentObject

    var body: some Scene {
        WindowGroup {
            VStack {
                if appData.isShowSlashScreen {
                    SlashScreenView()
                } else {
                    ContentView()
                        .environmentObject(appData) // Pass appData as environment object
                        .alert("Error", isPresented: $appData.isShowingAlert) {
                            Button("OK", role: .cancel) {
                                appData.isShowingAlert = false
                            }
                        } message: {
                            Text(appData.error)
                        }
                }
            }
            .animation(.spring(), value: appData.isShowSlashScreen)
            .onAppear {
                Task {
                    try await appData.checkUserAuthentication()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        appData.isShowSlashScreen = false
                    }
                }
            }
        }
    }
}
