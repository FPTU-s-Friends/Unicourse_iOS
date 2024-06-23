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
                    NavigationLink(destination: SupportContactView()) {
                        Label {
                            Text("Contact Support")
                        } icon: {
                            Image(systemName: "envelope.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    NavigationLink(destination: LiveChatView()) {
                        Label {
                            Text("Live Chat")
                        } icon: {
                            Image(systemName: "message.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }

                Section(header: Text("Resources")) {
                    NavigationLink(destination: HelpTopicsView()) {
                        Label {
                            Text("Help Topics")
                        } icon: {
                            Image(systemName: "book.circle.fill")
                                .foregroundColor(.orange)
                        }
                    }
                    NavigationLink(destination: FeedbackFormView()) {
                        Label {
                            Text("Send Feedback")
                        } icon: {
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(.purple)
                        }
                    }
                    NavigationLink(destination: WebViewUI(url: "https://unicourse.vn")) {
                        Label {
                            Text("Privacy Policy")
                        } icon: {
                            Image(systemName: "lock.circle.fill")
                                .foregroundColor(.red)
                        }
                    }

                    NavigationLink(destination: WebViewUI(url: "https://unicourse.vn/terms")) {
                        Label {
                            Text("Terms of Service")
                        } icon: {
                            Image(systemName: "doc.circle.fill")
                                .foregroundColor(.cyan)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Help & Support")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ButtonCircleUIView(systemName: "arrow.left.circle.fill") {
                        presentationMode.wrappedValue.dismiss()
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
    @Environment(\.presentationMode) var presentationMode // To control view dismissal
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
    HelpAndSupportView()
}
