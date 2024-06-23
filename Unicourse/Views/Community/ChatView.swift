//
//  ChatView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 18/6/24.
//
import Combine
import SDWebImageSwiftUI
import SwiftUI

struct ChatView: View {
    @EnvironmentObject var appData: AppData
    @StateObject private var viewModel = ChatViewModel()
    @State private var inputText: String = ""
    var roomId: String

    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.chatRoomDetail?.messages ?? [], id: \._id) { message in
                            MessageBubbleView(message: message)
                                .id(message._id)
                        }
                    }
                    .padding()
                    .onChange(of: viewModel.chatRoomDetail?.messages) { _ in
                        if let lastMessageId = viewModel.chatRoomDetail?.messages.last?._id {
                            scrollView.scrollTo(lastMessageId, anchor: .bottom)
                        }
                    }
                }
            }

            HStack {
                ZStack(alignment: .trailing) {
                    TextField("", text: $inputText)
                        .placeholder(when: inputText.isEmpty) {
                            Text("Send a message...")
                                .foregroundStyle(Color.gray.gradient)
                        }
                        .textFieldStyle(.plain)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                        .foregroundStyle(.black)
                        .background(Color.mainBackgroundColor)
                        .cornerRadius(20)
                        .padding(.horizontal)

                    Button {
                        inputText = ""
                    } label: {
                        Image(systemName: "paperplane.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32)
                            .foregroundStyle(inputText.isEmpty ? Color.gray.gradient : Color.mainColor1.gradient)
                            .padding(.trailing, 25)
                    }
                    .disabled(inputText.isEmpty)
                }
                .padding(.bottom, -15)
            }
            .padding(.vertical, 5)
            .padding(.bottom, 10)
        }
        .onDisappear {
            SDImageCache.shared.clearMemory()
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.mainColor3, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonBackUIView()
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    Image(systemName: "info.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 34)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 0.1)
                        )
                        .foregroundStyle(
                            Color.white,
                            Color.mainColor1.gradient
                        )
                        .padding(3)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                })
            }
        }
        .background {
            Color.mainBackgroundColor
                .ignoresSafeArea()
        }
        .onAppear {
            Task {
                do {
                    viewModel.isLoadingChatRoom = true
                    try await viewModel.getDetailChatRoom(roomId: roomId)
                    viewModel.isLoadingChatRoom = false
                } catch {
                    viewModel.error = "Failed to load chat room."
                    viewModel.isShowingAlert = true
                }
            }
        }
    }
}

#Preview {
    ChatView(roomId: "65ebe4d2d0cb58ef9cb250cc")
        .environmentObject(AppData())
}
