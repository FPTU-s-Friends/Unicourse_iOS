//
//  AllTopCourseViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 29/5/24.
//

import Foundation

class AllTopCourseViewModel: ObservableObject {
    @Published var searchCourses: [SearchCourseModel]
    @Published var isPresentedFilter = false
}
