//
//  AppDelegate.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Firebase
import GoogleSignIn
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate
{
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        FirebaseApp.configure()

        return true
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
        -> Bool
    {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
