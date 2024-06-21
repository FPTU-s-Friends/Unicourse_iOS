//
//  LiveChatView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

import SwiftUI

struct LiveChatView: View {
    @Environment(\.presentationMode) var presentationMode

    // URL của trang ChatBox trên Messenger
    private let messengerURL = "https://www.facebook.com/messages/t/288592671009847/"

    var body: some View {
        VStack {
            WebViewUI(url: messengerURL)
        }
    }
}

#Preview {
    LiveChatView()
}
