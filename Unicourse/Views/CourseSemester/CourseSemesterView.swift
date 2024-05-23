//
//  CourseSemesterView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/5/24.
//

import SwiftUI

struct CourseSemesterView: View {
    var semester: Int

    var body: some View {
        VStack {
            ScrollView {
                Text("\(semester)")
            }
        }
        .navigationBarTitle("Khoá học kì 9", displayMode: .large)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        CourseSemesterView(semester: 9)
    }
}
