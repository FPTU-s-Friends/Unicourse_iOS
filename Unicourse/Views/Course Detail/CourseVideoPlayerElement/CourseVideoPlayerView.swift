//
//  CourseVideoPlayerView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 17/5/24.
//

import SwiftUI

struct CourseVideoPlayerView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Video Streaming Area
                VStack {
                    // ViewModel to keep videoID
                    VideoStreamingView(videoID: "EWQbP1WaQzY")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, minHeight: 228)
                        .background(Color.gray)
                }

                // Syllabus + Comment

                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundStyle(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.88, green: 0.9, blue: 1), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.97, green: 0.97, blue: 0.99).opacity(0), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            ))

                    VStack(spacing: 10) {
                        // Chapter name
                        Text("CSI Buổi 1 - Spring 2022")
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack {
                            Image(systemName: "play.rectangle.fill")
                                .font(.system(size: 16, weight: .regular))

                            Text("Video 1")
                                .font(.system(size: 14, weight: .regular))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(14)
                }
            }
        }
    }
}

#Preview {
    CourseVideoPlayerView()
}
