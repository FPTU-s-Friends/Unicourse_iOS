//
//  CircleButtonUI.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 9/5/24.
//

import SwiftUI

struct CircleButtonUI: View {
    var isActive: Bool
    var systemName: String
    var symbolRenderingMode: SymbolRenderingMode? = .none

    var systemNameString: String {
        if isActive {
            "\(systemName).fill"
        } else {
            systemName
        }
    }

    var body: some View {
        Image(systemName: "\(systemNameString)")
            .symbolRenderingMode(symbolRenderingMode)
            .frame(width: 24, height: 24)
            .padding(6)
            .background(.white.opacity(0.5))
            .clipShape(Circle())
    }
}

#Preview {
    CircleButtonUI(isActive: false, systemName: "heart")
}
