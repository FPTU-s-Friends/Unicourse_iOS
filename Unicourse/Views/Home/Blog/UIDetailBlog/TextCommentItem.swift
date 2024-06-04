//
//  TextCommentItem.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 4/6/24.
//

import SwiftUI

struct TextCommentItem: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var webViewHeight: CGFloat = .zero
    var text: String

    var body: some View {
        WebView(htmlContent: text, webViewHeight: $webViewHeight)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            .multilineTextAlignment(.leading)
            .frame(height: webViewHeight)
            .font(.system(size: 14, weight: .regular))
    }
}

#Preview {
    TextCommentItem(text: "")
}
