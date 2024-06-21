//
//  HelpAndSupportView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

import SwiftUI

struct HelpAndSupportView: View {
    @Environment(\.presentationMode) var presentationMode // To control view dismissal

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("FAQ")) {
                    ForEach(faqs, id: \.question) { faq in
                        NavigationLink(destination: FAQDetailView(faq: faq)) {
                            Text(faq.question)
                        }
                    }
                }

                Section(header: Text("Support")) {
                    NavigationLink(destination: ContactSupportView()) {
                        Label("Contact Support", systemImage: "envelope")
                    }
                    NavigationLink(destination: LiveChatView()) {
                        Label("Live Chat", systemImage: "message")
                    }
                }

                Section(header: Text("Resources")) {
                    NavigationLink(destination: HelpTopicsView()) {
                        Label("Help Topics", systemImage: "book")
                    }
                    NavigationLink(destination: FeedbackFormView()) {
                        Label("Send Feedback", systemImage: "pencil")
                    }
                    NavigationLink(destination: WebViewUI(url: "https://unicourse.vn/privacy")) {
                        Label("Privacy Policy", systemImage: "lock.shield")
                    }
                    NavigationLink(destination: WebViewUI(url: "https://unicourse.vn/terms")) {
                        Label("Terms of Service", systemImage: "doc.plaintext")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Help & Support")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Dismiss the view
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
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
        }
    }
}

struct FAQ {
    let question: String
    let answer: String
}

// Sample FAQs
let faqs: [FAQ] = [
    FAQ(question: "How do I purchase a course?", answer: "To purchase a course, go to the course page and click on 'Buy Now'."),
    FAQ(question: "How do I access my courses?", answer: "You can access your purchased courses in the 'My Courses' section."),
    // Add more FAQs as needed
]

struct FAQDetailView: View {
    let faq: FAQ

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(faq.question)
                    .font(.title2)
                    .bold()
                Text(faq.answer)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("FAQ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContactSupportView: View {
    var body: some View {
        Form {
            Section(header: Text("Contact Us")) {
                Text("For support, email us at support@unicourse.com or call us at +123456789.")
            }
        }
        .navigationTitle("Contact Support")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LiveChatView: View {
    var body: some View {
        Text("Live Chat feature coming soon!")
            .font(.headline)
            .padding()
            .navigationTitle("Live Chat")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct HelpTopicsView: View {
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
    }
}

struct HelpTopicDetailView: View {
    let topic: String

    var body: some View {
        ScrollView {
            Text("Detailed information about \(topic).")
                .padding()
        }
        .navigationTitle(topic)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedbackFormView: View {
    @State private var feedback: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Send Us Feedback")) {
                TextEditor(text: $feedback)
                    .frame(height: 150)
            }
            Button("Submit") {
                showAlert = true
            }
            .alert("Thank you for your feedback!", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
        .navigationTitle("Feedback")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WebViewUI: View {
    let url: String

    var body: some View {
        if let url = URL(string: url) {
            SafariView(url: url)
                .edgesIgnoringSafeArea(.all)
        } else {
            Text("Invalid URL")
        }
    }
}

// Helper to display web content
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

#Preview {
    HelpAndSupportView()
}
