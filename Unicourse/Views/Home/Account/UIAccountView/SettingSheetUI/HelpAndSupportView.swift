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
                Section(header: Text("Câu hỏi thường gặp")) {
                    ForEach(faqs, id: \.question) { faq in
                        NavigationLink(destination: FAQDetailView(faq: faq)) {
                            Text(faq.question)
                        }
                    }
                }

                Section(header: Text("Hỗ trợ")) {
                    NavigationLink(destination: SupportContactView()) {
                        Label {
                            Text("Liên hệ hỗ trợ")
                        } icon: {
                            Image(systemName: "envelope.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    NavigationLink(destination: LiveChatView()) {
                        Label {
                            Text("Trò chuyện trực tiếp")
                        } icon: {
                            Image(systemName: "message.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }

                Section(header: Text("Tài nguyên")) {
                    NavigationLink(destination: HelpTopicsView()) {
                        Label {
                            Text("Chủ đề trợ giúp")
                        } icon: {
                            Image(systemName: "book.circle.fill")
                                .foregroundColor(.orange)
                        }
                    }
                    NavigationLink(destination: {
                        FeedbackFormView()
                            .navigationBarBackButtonHidden(true)
                    }) {
                        Label {
                            Text("Gửi phản hồi")
                        } icon: {
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(.purple)
                        }
                    }
                    NavigationLink(destination: WebViewUI(url: "https://unicourse.vn")) {
                        Label {
                            Text("Chính sách quyền riêng tư")
                        } icon: {
                            Image(systemName: "lock.circle.fill")
                                .foregroundColor(.red)
                        }
                    }

                    NavigationLink(destination: WebViewUI(url: "https://unicourse.vn/terms")) {
                        Label {
                            Text("Điều khoản dịch vụ")
                        } icon: {
                            Image(systemName: "doc.circle.fill")
                                .foregroundColor(.cyan)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Trợ giúp & Hỗ trợ")
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
    FAQ(question: "Làm thế nào để mua khóa học?", answer: "Để mua khóa học, truy cập trang khóa học và nhấn 'Mua ngay'."),
    FAQ(question: "Làm thế nào để truy cập các khóa học ?", answer: "Bạn có thể truy cập các khóa học đã mua trong mục 'Khóa học của tôi'."),
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
        .navigationTitle("Câu hỏi thường gặp")
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
