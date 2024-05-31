//
//  LectureInfoView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 30/5/24.
//

import SwiftUI

struct LectureInfoView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss: DismissAction
    @StateObject private var vm = LectureViewModel()
    var lecture_id: String

    var body: some View {
        VStack {
            HStack {
                Image(.defaultProfile)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)

                Text("Dr.Angela Yu")
                    .font(.system(size: 30, weight: .bold))
                    .bold()
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal, 10)
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
        .onAppear {
            vm.getLectureById(lecture_id: lecture_id, token: appData.token)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        LectureInfoView(lecture_id: "662f61f6b57741e90fac0a5b")
            .environmentObject(AppData())
    }
}
