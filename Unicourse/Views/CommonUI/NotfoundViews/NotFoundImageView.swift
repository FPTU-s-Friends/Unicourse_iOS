//
//  404UIView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 4/6/24.
//

import SwiftUI

struct NotFoundImageView: View {
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        VStack {
            Image(._404)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height, alignment: .center)
        }
    }
}

#Preview {
    NotFoundImageView(width: 400, height: 400)
}
