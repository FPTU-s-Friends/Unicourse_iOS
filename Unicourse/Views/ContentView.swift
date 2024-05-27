//
//  ContentView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/5/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @EnvironmentObject var appData: AppData

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
    }
}

#Preview {
    ContentView()
        .environmentObject(AppData())
}
