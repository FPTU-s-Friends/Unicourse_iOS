//
//  CommunityView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import SwiftUI

struct CommunityView: View {
    @StateObject var viewModel = CommunityViewModel()

    var body: some View {
        ZStack {
            Color.mainBackgroundColor.ignoresSafeArea()

            Image(.appIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.3)
                .opacity(0.3)

            ScrollView {
                ForEach(viewModel.allChatRooms, id: \._id) { chatRoom in
                    NavigationLink {
                        ChatView(roomId: chatRoom._id)
                            .navigationTitle(chatRoom.name)
                            .navigationBarBackButtonHidden(true)

                    } label: {
                        ChatGroupMiniView(chatRoom: chatRoom)
                    }
                }

                .padding(.horizontal, 10)
                .searchable(text: $viewModel.searchString, prompt: Text("Tìm kiếm"))
            }

            if viewModel.isLoadingChatRoom {
                LoadingIndicatorView(isLoading: .constant(true))
                    .animation(.spring, value: viewModel.isLoadingChatRoom)
            }
        }
        .onAppear {
            Task {
                viewModel.isLoadingChatRoom = true
                try await viewModel.getAllChatRooms()
                viewModel.isLoadingChatRoom = false
            }
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(
                title: Text("Error").foregroundStyle(Color.red),
                message: Text(viewModel.error),
                dismissButton: .cancel(Text("Ok")) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        viewModel.isShowingAlert = false
                    }
                }
            )
        }
        .navigationTitle("Cộng đồng")
        .navigationBarTitleDisplayMode(.large)
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
                        viewModel.isPresentedCreateGroup = true
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
        .sheet(isPresented: $viewModel.isPresentedCreateGroup) {
            CreateChatRoomSheetView()
                .presentationDetents([.large, .medium])
        }
    }
}

#Preview {
    NavigationStack {
        CommunityView()
    }
}
