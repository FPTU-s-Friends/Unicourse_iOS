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
            .font(.system(size: 20))
            .symbolRenderingMode(symbolRenderingMode)
            .frame(width: 32, height: 32)
            .background(.white.opacity(0.5))
            .clipShape(Circle())
    }
}

#Preview {
    CircleButtonUI(isActive: false, systemName: "heart")
}
