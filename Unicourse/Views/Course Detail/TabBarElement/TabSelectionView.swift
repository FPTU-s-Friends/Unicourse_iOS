//
//  TabSelectionView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/5/24.
//

import Foundation
import SwiftUI

struct TabSelectionView: View {
    @Binding var tabSelection: Int
    @Namespace private var buttonId
    private let selectionButtons = ["Chi tiết", "Lộ trình", "Đánh giá"]

    var body: some View {
        HStack(alignment: .top, spacing: 40) {
            ForEach(selectionButtons.indices, id: \.self) {
                index in
                VStack {
                    Button(selectionButtons[index]) {
                        withAnimation(.spring) {
                            tabSelection = index
                        }
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(tabSelection == index ? .primary : .secondary)
                    .padding(.horizontal)
                    if tabSelection == index {
                        Capsule()
                            .frame(width: 60, height: 4)
                            .padding(.horizontal, 4)
                            .foregroundStyle(Color(hex: "#16AEF4"))
                            .matchedGeometryEffect(id: "ID", in: buttonId)
                    } else {
                        EmptyView()
                            .frame(height: 4)
                            .matchedGeometryEffect(id: /*@START_MENU_TOKEN@*/"ID"/*@END_MENU_TOKEN@*/, in: buttonId)
                    }
                }
            }
        }
    }
}
