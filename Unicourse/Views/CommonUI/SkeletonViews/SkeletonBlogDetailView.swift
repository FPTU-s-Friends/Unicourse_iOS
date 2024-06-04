//
//  SkeletonBlogDetailView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 3/6/24.
//

import SwiftUI

struct SkeletonBlogDetailView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Skeleton for Async Image
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .cornerRadius(10)
                    .shimmerWithWave()
                   
                VStack(alignment: .leading) {
                    // Skeleton for Icon Row
                    HStack(spacing: 18) {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 12, height: 12)
                            .shimmerWithWave()
                        
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 12, height: 12)
                            .shimmerWithWave()
                        
                        HStack(spacing: 5) {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 12, height: 12)
                                .shimmerWithWave()
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 50, height: 12)
                                .shimmerWithWave()
                        }
                    }
                    .padding(.top, 10)
                    .padding(.leading, 2)
              
                    // Skeleton for Tags Row
                    HStack(spacing: 10) {
                        ForEach(0 ..< 3) { _ in
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 50, height: 20)
                                .cornerRadius(5)
                                .shimmerWithWave()
                        }
                    }
                    .padding(.vertical, 10)
                    
                    // Skeleton for Title
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 24)
                        .cornerRadius(5)
                        .padding(.vertical, 10)
                        .shimmerWithWave()
                    
                    // Skeleton for Description
                    VStack {
                        HStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60, height: 16)
                                .shimmerWithWave()
                            
                            Spacer()
                            
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 14, height: 14)
                                .shimmerWithWave()
                        }
                        .padding(.bottom, 10)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 50)
                            .cornerRadius(5)
                            .shimmerWithWave()
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                }
                .padding(.horizontal, 10)
                
                // Skeleton for WebView
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .frame(width: geometry.size.width * 0.95)
                    .cornerRadius(10)
                    .padding(.vertical, 10)
                    .shimmerWithWave()
                
                // Skeleton for Related Blogs
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 100)
                    .cornerRadius(10)
                    .padding(.vertical, 10)
                    .shimmerWithWave()
            }
        }
    }
}

#Preview {
    SkeletonBlogDetailView()
}
