//
//  SearchResultItemView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct SearchResultItemView: View {
    var title: String
    var description: String
    var thumbnail: String
    var lectureName: String
    var lectureImage: String
    var courseType: CourseEnrollType
    var courseAmount: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                VStack {
                    WebImage(url: URL(string: thumbnail)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 165)
                        
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: .infinity, height: 165)
                            .padding(10)
                            .shimmerWithWave()
                    }
                }
                .frame(width: 190)
                
                VStack(alignment: .leading) {
                    HStack {
                        WebImage(url: URL(string: lectureImage)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 23, height: 23)
                                .cornerRadius(20)
                            
                        } placeholder: {
                            ProgressView()
                        }
                        Text("\(lectureName)")
                            .font(.system(size: 10, weight: .medium))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal, 15)
                    
                    Text(title)
                        .font(.system(size: 12))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .padding(.horizontal, 15)
                    
                    Spacer()
                    
                    if courseType == .free {
                        HStack {
                            Text("Free")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.green)
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                       
                    } else if courseType == .fee {
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("\(courseAmount)")
                                .font(.system(size: 12, weight: .bold))
                                .lineSpacing(20)
                                .foregroundColor(.mainColor1)
                            Text("\(courseAmount + 20000)")
                                .font(.system(size: 10))
                                .lineSpacing(20)
                                .strikethrough()
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                    }
                }
                
                RatingStars(rating: 4)
                    .offset(x: -40, y: 140)
            }
            .frame(width: 180, height: 260)
            .background(.white)
            .cornerRadius(12)
        }
    }
}

#Preview {
    SearchResultItemView(title: "", description: "", thumbnail: "", lectureName: "", lectureImage: "", courseType: .free, courseAmount: 0)
}
