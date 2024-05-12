//
//  TabButton.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 10/5/24.
//

import SwiftUI

struct TabButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: CGFloat.mainTitlePath, weight: .semibold))
                    .foregroundStyle(.black)
                Rectangle()
                    .fill(isActive ? Color.activeColor : Color.clear)
                    .frame(width: 60, height: 4)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    TabButton(title: "Mới nhất", isActive: true) {}
}
