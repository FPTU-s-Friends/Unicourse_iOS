//
//  ExpendableView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 14/5/24.
//

import SwiftUI

struct ExpandableView: View {
    @Namespace private var namepsace
    @State private var show = false

    var thumbnail: ThumbnailView
    var expanded: ExpandedView

    var body: some View {
        ZStack {
            if !show {
                thumbnailView()
            } else {
                expandedlView()
            }
        }
        .onTapGesture {
            if !show {
                withAnimation(.spring()) {
                    show.toggle()
                }
            }
        }
    }

    // View chưa xem thêm
    @ViewBuilder
    private func thumbnailView() -> some View {
        ZStack {
            thumbnail
                .matchedGeometryEffect(id: "view", in: namepsace, isSource: false)
        }
        .background(
            Color.white
                .matchedGeometryEffect(id: "background", in: namepsace, isSource: false)
        )
        .cornerRadius(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color(hex: "#EDEDED"), lineWidth: 0.5)
                .matchedGeometryEffect(id: "mask", in: namepsace, isSource: false)
        }
    }

    // View khi hiện ra
    @ViewBuilder
    private func expandedlView() -> some View {
        ZStack {
            expanded
                .matchedGeometryEffect(id: "view", in: namepsace, isSource: false)
                .background(
                    Color.white
                        .matchedGeometryEffect(id: "background", in: namepsace, isSource: false)
                )
                .cornerRadius(16)
                .overlay {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color(hex: "#EDEDED"), lineWidth: 0.5)
                        .matchedGeometryEffect(id: "mask", in: namepsace, isSource: false)
                }
            Button(action: {
                withAnimation(.spring()) {
                    show.toggle()
                }
            }, label: {
                VStack {
                    Text("Thu nhỏ")
                        .font(.system(size: 12))
                }
                .padding(.horizontal, 11)
                .padding(.vertical, 0)
                .frame(height: 21, alignment: .center)
                .background(Color(hex: "#DDE0FF"))
                .cornerRadius(100)
            })
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .matchedGeometryEffect(id: "mask", in: namepsace, isSource: false)
        }
    }
}
