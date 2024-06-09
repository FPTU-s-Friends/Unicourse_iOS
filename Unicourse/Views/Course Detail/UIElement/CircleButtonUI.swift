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
    var symbolRenderingMode: SymbolRenderingMode? = .multicolor

    var systemNameString: String {
        if isActive {
            "\(systemName).fill"
        } else {
            systemName
        }
    }

    var body: some View {
        Image(systemName: "\(systemNameString)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .symbolRenderingMode(symbolRenderingMode)
            .frame(width: 30)
            .padding(4)
    }
}

#Preview {
    CircleButtonUI(isActive: false, systemName: "heart")
}
