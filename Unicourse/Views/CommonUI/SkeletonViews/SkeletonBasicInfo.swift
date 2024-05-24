//
//  SkeletonBasicInfo.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 23/5/24.
//

import SwiftUI

struct SkeletonBasicInfo: View {
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 18)
                    .cornerRadius(4)
                    .frame(maxWidth: 200, alignment: .leading)
                Spacer()
            }.padding(.bottom, 20)

            HStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 12)
                    .cornerRadius(4)

                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 12)
                    .cornerRadius(4)

                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 12)
                    .cornerRadius(4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 18)
                    .cornerRadius(4)

                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 12)
                    .cornerRadius(4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .redacted(reason: .placeholder)
    }
}

#Preview {
    SkeletonBasicInfo()
}
