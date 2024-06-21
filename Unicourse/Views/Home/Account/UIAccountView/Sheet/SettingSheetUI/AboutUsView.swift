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
                VStack(alignment: .leading, spacing: 10) {
                    // Top Banner Image
                    Image("MainBanner")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                        .padding(.horizontal, 5)
                
                    // App Icon and Introduction
                    HStack(alignment: .center, spacing: 15) {
                        Image("appIcon") // Ensure this image exists in your assets
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        Text("Welcome to Unicourse, your number one source for all things related to online courses. We're dedicated to providing you the very best of education, with an emphasis on quality content, expert instructors, and exceptional support.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal, 20)
                    
                    // Our Mission Section
                    sectionView(
                        title: "Our Mission",
                        text: "Our mission is to make quality education accessible to everyone, everywhere. We aim to empower learners by providing them with the tools and knowledge they need to succeed in their personal and professional lives.",
                        imageName: "home-banner2" // Add a relevant image in your assets
                    )
                    
                    // Our Vision Section
                    sectionView(
                        title: "Our Vision",
                        text: "We envision a world where anyone, regardless of location or background, can access the education they need to achieve their dreams. We strive to create a community of lifelong learners who are passionate about personal growth and development.",
                        imageName: "home-banner3" // Add a relevant image in your assets
                    )
                    
                    // Contact Us Section
                    VStack(alignment: .leading, spacing: 15) {
                        Image("contactUsImage") // Ensure this image exists in your assets
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        Text("Contact Us")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Have any questions or feedback? We'd love to hear from you! Reach out to us at ")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.blue)
                            .underline()
                        
                        Text("[unicourse.learningplatform@gmail.com](mailto:unicourse.learningplatform@gmail.com)")
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    
                    // Visit Us Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Visit Us")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("For more information, visit our website at ")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.blue)
                            .underline()
                        
                        Text("[unicourse.vn](https://unicourse.vn)")
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("About Us")
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
    
    // Helper View to create sections with title, text, and image
    private func sectionView(title: String, text: String, imageName: String) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Image(imageName) // Ensure this image exists in your assets
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 5)
            
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(text)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
