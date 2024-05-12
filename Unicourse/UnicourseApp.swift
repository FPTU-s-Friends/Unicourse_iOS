//
//  UnicourseApp.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/5/24.
//

import Firebase
import FirebaseCore
import SwiftUI

@main
struct UnicourseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appData = AppData() // Use @StateObject instead of @EnvironmentObject

    var body: some Scene {
        WindowGroup {
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
}
