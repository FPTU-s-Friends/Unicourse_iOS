//
//  AboutUsView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

import SwiftUI

struct AboutUsView: View {
    @Environment(\.presentationMode) var presentationMode // Use environment to control view dismissal

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    // Use the app icon image from assets
                    Image("appIcon") // Use string literal for image name
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding(.top, 20)
                    
                    Text("Welcome to Unicourse, your number one source for all things related to online courses. We're dedicated to providing you the very best of education, with an emphasis on quality content, expert instructors, and exceptional support.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Our Mission")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Our mission is to make quality education accessible to everyone, everywhere. We aim to empower learners by providing them with the tools and knowledge they need to succeed in their personal and professional lives.")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Our Vision")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("We envision a world where anyone, regardless of location or background, can access the education they need to achieve their dreams. We strive to create a community of lifelong learners who are passionate about personal growth and development.")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Contact Us")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Have any questions or feedback? We'd love to hear from you! Reach out to us at contact@unicourse.com.")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("About Us")
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

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
