//
//  FeedbackFormView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

import SwiftUI

struct FeedbackFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var feedback: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 40))
                        .padding(.leading, 10)
                    Text("We value your feedback!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.horizontal, 10)
                }

                Text("Please let us know what you think about our platform. Your feedback helps us improve.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)

                Form {
                    Section(header: HStack {
                        Image(systemName: "pencil.and.outline")
                            .foregroundColor(.blue)
                        Text("Your Feedback")
                    }) {
                        TextEditor(text: $feedback)
                            .frame(height: UIScreen.main.bounds.height * 0.5)
                    }
                    .cornerRadius(10)
                }

                .cornerRadius(10)

                Spacer()

                Button(action: {
                    showAlert = true
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
                .alert("Thank you for your feedback!", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                }
            }
            .navigationTitle("Feedback")
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
}

struct FeedbackFormView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackFormView()
    }
}
