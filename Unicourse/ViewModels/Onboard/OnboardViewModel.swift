//
//  OnboardViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/5/24.
//

import Foundation

class OnboardViewModel: ObservableObject {
    @Published var pageIndex = 0
    @Published var navigateToLogin = false
}
