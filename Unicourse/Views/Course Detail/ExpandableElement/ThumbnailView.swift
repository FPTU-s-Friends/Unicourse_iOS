//
//  ThumbnailView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 14/5/24.
//

import SwiftUI

struct ThumbnailView: View {
    var id = UUID()

    @ViewBuilder var content: any View

    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}
