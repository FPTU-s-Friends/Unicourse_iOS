//
//  SheetCommentView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 3/6/24.
//

import SwiftUI

struct SheetCommentView: View {
    var body: some View {
        ZStack {
            Color.mainColor3
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    HStack {
                        HStack(spacing: 5) {
                            AsyncImage(url: URL(string: DefaultURL.defaultUserURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                                    .cornerRadius(20)
                            } placeholder: {
                                ProgressView()
                            }
                            Text("Nguyễn Trung Kiên")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.gray)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        }
                        .padding(.horizontal, 10)
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    SheetCommentView()
}
