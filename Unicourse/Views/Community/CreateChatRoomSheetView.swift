//
//  CreateChatRoomSheetView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/6/24.
//

import SwiftUI

struct CreateChatRoomSheetView: View {
    @State private var roomName: String = ""
    @State private var roomDescription: String = ""
    @State private var isPrivate: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Chat Room Details")) {
                        TextField("Room Name", text: $roomName)
                            .textFieldStyle(.plain)
                        TextField("Description", text: $roomDescription)
                            .textFieldStyle(.plain)
                    }

                    Section(header: Text("Privacy")) {
                        Toggle(isOn: $isPrivate) {
                            Text("Private Room")
                        }
                    }
                }

                Spacer()
            }
            .background {
                Color.mainBackgroundColor
                    .ignoresSafeArea()
            }
            .navigationTitle("Create Chat Room")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Submit") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CreateChatRoomSheetView()
}
