//
//  CommunityView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct CommunityView: View {
    @State var searchString: String = ""
    @State private var gradientHeight: CGFloat = 0
    @State var isPresentedCreateGroup = false

    var body: some View {
        ZStack {
            Color.mainBackgroundColor.ignoresSafeArea()

            Image(.appIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.3)
                .opacity(0.3)

            ScrollView {
                ForEach(1 ..< 3) { _ in
                    NavigationLink {
                        ChatView()
                            .navigationTitle("Group Chat 1")
                            .navigationBarBackButtonHidden(true)

                    } label: {
                        ChatGroupMiniView()
                    }
                }

                .padding(.horizontal, 10)
                .searchable(text: $searchString, prompt: Text("Tìm kiếm"))
            }
        }
        .navigationTitle("Cộng đồng 🌏")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.mainBackgroundColor, for: .navigationBar)
        .toolbarBackground(
            .automatic,
            for: .navigationBar
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                ButtonBackUIView()
            }

            ToolbarItem(placement: .destructiveAction) {
                Button {
                    withAnimation {
                        isPresentedCreateGroup = true
                    }
                } label: {
                    Image(systemName: "square.and.pencil.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 34)
                        .foregroundStyle(
                            Color.white,
                            Color.mainColor1.gradient
                        )
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 0.1)
                        )
                        .padding(3)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
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
