//
//  PrivacyView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

import SwiftUI

struct PrivacyView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: "lock.shield.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                
                Text("Privacy Policy")
                    .font(.largeTitle)
                    .fontWeight(.bold)
             
                Text("Last updated: June 21, 2024")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                    .padding(.vertical, 10)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Introduction")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("""
                    Welcome to Unicourse. We are committed to protecting your personal information and your right to privacy. If you have any questions or concerns about this privacy notice or our practices with regard to your personal information, please contact us at unicourse.learningplatform@gmail.com.
                    """)
                    .font(.body)
                    .foregroundColor(.secondary)
                    
                    Text("Information We Collect")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("""
                    We collect personal information that you voluntarily provide to us when you register on the Unicourse app, express an interest in obtaining information about us or our products and services, when you participate in activities on the app, or otherwise when you contact us.
                    """)
                    .font(.body)
                    .foregroundColor(.secondary)
                    
                    Text("How We Use Your Information")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("""
                    We use personal information collected via our app for a variety of business purposes described below. We process your personal information for these purposes in reliance on our legitimate business interests, in order to enter into or perform a contract with you, with your consent, and/or for compliance with our legal obligations.
                    """)
                    .font(.body)
                    .foregroundColor(.secondary)
                    
                    Text("Sharing Your Information")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("""
                    We may process or share your data that we hold based on the following legal basis:
                    - Consent: We may process your data if you have given us specific consent to use your personal information for a specific purpose.
                    - Legitimate Interests: We may process your data when it is reasonably necessary to achieve our legitimate business interests.
                    """)
                    .font(.body)
                    .foregroundColor(.secondary)
                    
                    Text("Your Privacy Rights")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("""
                    In some regions (like the European Economic Area), you have rights that allow you greater access to and control over your personal information. You may review, change, or terminate your account at any time.
                    """)
                    .font(.body)
                    .foregroundColor(.secondary)
                    
                    Text("Contact Us")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("""
                    If you have questions or comments about this policy, you may email us at unicourse.learningplatform@gmail.com or by post to:
                    Unicourse
                    Lot E2a-7 D1 St, High-tech park,
                    Long Thanh My Ward,
                    District 9 - Ho Chi Minh City, EC 70000
                    """)
                    .font(.body)
                    .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .background(Color.mainBackgroundColor)
        .navigationTitle("Privacy Policy")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.mainColor3.gradient, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonCircleUIView(systemName: "arrow.left.circle.fill") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
