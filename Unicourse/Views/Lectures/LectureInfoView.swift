//
//  LectureInfoView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 30/5/24.
//

import SwiftUI

struct LectureInfoView: View {
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        VStack {}
            .navigationTitle("Giảng viên")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .frame(width: 10, height: 18)
                            .padding(.horizontal, 15)
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        LectureInfoView()
    }
}
