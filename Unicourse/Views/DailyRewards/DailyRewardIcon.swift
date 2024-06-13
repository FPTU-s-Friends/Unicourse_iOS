//
//  DailyRewardButton.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 3/6/24.
//

import SwiftUI

struct DailyRewardIcon: View {
    var body: some View {
        Button {} label: {
            Text("🎁")
                .font(.system(size: 50))
        }
        .disabled(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DailyRewardIcon()
    }
}
