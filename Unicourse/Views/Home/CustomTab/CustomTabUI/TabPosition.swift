//
//  TabPosition.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 27/5/24.
//

import SwiftUI

// custom View extension

struct positionKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func viewPosition(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .global)

                    Color.clear
                        .preference(key: positionKey.self, value: rect)
                        .onPreferenceChange(positionKey.self, perform: completion)
                }
            }
    }
}
