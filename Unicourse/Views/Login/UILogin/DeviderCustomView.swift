//
//  DeviderCustomView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/5/24.
//

import SwiftUI

struct DeviderCustomView: View {
    var text: String
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    DeviderCustomView(text: "Hoặc")
}
