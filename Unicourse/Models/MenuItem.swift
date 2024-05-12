//
//  MenuItem.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct MenuItem: Identifiable {
    let id: Int
    let systemName: String
    let title: String
    let destination: AnyView
    let colorIcon: Color

    init<T: View>(id: Int, systemName: String, title: String, destination: T, colorIcon: Color) {
        self.id = id
        self.systemName = systemName
        self.title = title
        self.destination = AnyView(destination)
        self.colorIcon = colorIcon
    }
}
