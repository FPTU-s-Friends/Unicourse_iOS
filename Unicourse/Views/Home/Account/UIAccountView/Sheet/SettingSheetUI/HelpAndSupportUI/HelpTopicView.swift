//
//  HelpTopicView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

import SwiftUI

struct HelpTopicsView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        List {
            // List of help topics
            NavigationLink(destination: HelpTopicDetailView(topic: "Getting Started")) {
                Text("Getting Started")
            }
            NavigationLink(destination: HelpTopicDetailView(topic: "Managing Your Account")) {
                Text("Managing Your Account")
            }
            // Add more topics as needed
        }
        .navigationTitle("Help Topics")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonCircleUIView(systemName: "arrow.left.circle.fill") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct HelpTopicDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let topic: String

    var body: some View {
        ScrollView {
            Text("Detailed information about \(topic).")
                .padding()
        }
        .navigationTitle(topic)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonCircleUIView(systemName: "arrow.left.circle.fill") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    HelpTopicsView()
}
