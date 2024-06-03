//
//  WebView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var htmlContent: String
    @Binding var webViewHeight: CGFloat // Thêm binding để cập nhật chiều cao

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false // Tắt tính năng scroll của WebView
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // Tạo HTML với nội dung và font chữ mặc định của trình duyệt
        let html = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
        body {
            font-family: -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
            font-size: 16px; /* Kích cỡ font phù hợp */
            margin: 0;
            padding: 0;
            background-color: #F3FBFF;
            padding: 10px;
        }
        h1 {
            color: "#5EDFF5"
        }
        h2 {
            color: "#5EDFF5"
        }
        h3 {
            color: "#5EDFF5"
        }
        </style>
        </head>
        <body>
        \(htmlContent)
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)

        // Cập nhật chiều cao của WebView
        DispatchQueue.main.async {
            webView.evaluateJavaScript("document.readyState", completionHandler: { readyState, _ in
                if readyState != nil {
                    webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { contentHeight, _ in
                        if let contentHeight = contentHeight as? CGFloat {
                            self.webViewHeight = contentHeight
                        }
                    })
                }
            })
        }
    }
}
