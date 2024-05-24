//
//  VideoStreamingView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 17/5/24.
//

import SwiftUI
import WebKit

struct VideoStreamingView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> some WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // tạo link và guard xem ok hay ko
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }

        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}
