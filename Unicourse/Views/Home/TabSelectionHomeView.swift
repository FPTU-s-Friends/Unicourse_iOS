//
//  TabSelectionHomeView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import SwiftUI

struct TabSelectionHomeView: View {
    @Binding var tabSelection: Int
    @Namespace private var buttonId
    let selectionButtons: [String]

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            ForEach(selectionButtons.indices, id: \.self) {
                index in
                VStack {
                    Button(selectionButtons[index]) {
                        withAnimation(.spring) {
                            tabSelection = index
                        }
                    }
                    .font(.system(size: 12, weight: .medium))
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

#Preview {
    TabSelectionHomeView(tabSelection: .constant(0), selectionButtons: ["Trang chủ", "Khoá học", "Cộng đồng", "Tài khoản"])
}
