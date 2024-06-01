//
//  PathTitle.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 8/5/24.
//

import SwiftUI

struct PathTitle: View {
    let title: String
    let isHaveButton: Bool
    let actionButton: () -> Void

    init(title: String, isHaveButton: Bool, actionButton: @escaping () -> Void = {}) {
        self.title = title
        self.isHaveButton = isHaveButton
        self.actionButton = actionButton
    }

    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: .mainTitlePath, weight: .bold))
                Image(.based)
            }
            Spacer()
            if isHaveButton {
                Button(action: {
                    actionButton()
                }, label: {
                    Text("Xem tất cả")
                        .padding(.horizontal, 11)
                        .font(.system(size: .mainTitleButtonPath, weight: .regular))
                        .foregroundStyle(.white)
                        .frame(height: 25)
                        .background(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(Capsule())
                })
            }
        }
    }
}

#Preview {
    PathTitle(title: "Đang học", isHaveButton: true, actionButton: { print("123") })
}
