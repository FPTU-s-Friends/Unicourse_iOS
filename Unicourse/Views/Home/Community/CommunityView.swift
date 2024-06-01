//
//  CommunityView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct CommunityView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @State var searchString: String = ""
    @State private var gradientHeight: CGFloat = 0
    @State var isPresentedCreateGroup = false

    var body: some View {
        VStack {
            List {
                ForEach(1 ..< 10) { _ in
                    ChatGroupMiniView()
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchString, prompt: Text("Tìm kiếm"))
        }
        .background {
            Color.mainBackgroundColor.ignoresSafeArea()
        }
        .navigationTitle("Cộng đồng ")
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.mainBackgroundColor, for: .navigationBar)
        .toolbarBackground(
            .automatic,
            for: .navigationBar
        )
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

            ToolbarItem(placement: .destructiveAction) {
                Button {
                    withAnimation {
                        isPresentedCreateGroup = true
                    }
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20)
                }
            }
        }
        .toolbarTitleDisplayMode(.large)
        .sheet(isPresented: $isPresentedCreateGroup) {
            Text("Tạo group ở đây")
                .presentationDetents([.large, .medium])
        }
    }
}

#Preview {
    NavigationStack {
        CommunityView()
    }
}
