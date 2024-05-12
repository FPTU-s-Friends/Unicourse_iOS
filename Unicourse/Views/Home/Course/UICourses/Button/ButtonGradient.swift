//
//  ButtonGradient.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 8/5/24.
//

import Foundation
import SwiftUI

struct ButtonGradient: View {
    var title: String
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 100, height: 30)
                .background(LinearGradient(colors: [.mainColor1, .mainColor2], startPoint: .leading, endPoint: .bottom))
                .clipShape(RoundedRectangle(cornerRadius: 7.0))
        })
    }
}
