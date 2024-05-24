//
//  CourseVideoPlayerView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 17/5/24.
//

import SwiftUI

struct Mockdatas: Identifiable {
    var id = UUID()
    var nameChapter: String
    var isDone: Bool
    var listVideo: [VideoChapter]

    init(nameChapter: String, isDone: Bool, listVideo: [VideoChapter]) {
        self.nameChapter = nameChapter
        self.isDone = isDone
        self.listVideo = listVideo
    }

    static var data: [Mockdatas] = [
        Mockdatas(nameChapter: "JPD113 buổi 1 - Spring 2022", isDone: Bool.random(),
                  listVideo: [
                      VideoChapter(titleVideo: "Video 1", totalTime: 80),
                      VideoChapter(titleVideo: "Video 2", totalTime: 90)
                  ]),
        Mockdatas(nameChapter: "JPD113 buổi 2 - Spring 2022", isDone: Bool.random(),
                  listVideo: [
                      VideoChapter(titleVideo: "Video 1", totalTime: 70),
                      VideoChapter(titleVideo: "Video 2", totalTime: 90)
                  ]),
        Mockdatas(nameChapter: "JPD113 buổi 3 - Spring 2022 ", isDone: Bool.random(),
                  listVideo: [
                      VideoChapter(titleVideo: "Video 1", totalTime: 70),
                      VideoChapter(titleVideo: "Video 2", totalTime: 90),
                      VideoChapter(titleVideo: "Video 3", totalTime: 90)
                  ])
    ]
}

struct CourseVideoPlayerView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
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
                                Gradient.Stop(color: Color(red: 0.97, green: 0.97, blue: 0.99).opacity(0), location: 1.00)
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)))

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

                    ScrollView {
                        VStack {
                            ExpandableView(
                                thumbnail: ThumbnailView(content: {
                                    ThumbnailHeading(totalTime: 2, chapterName: " item.nameChapter", isDone: false)

                                }),
                                expanded: ExpandedView(content: {
                                    VStack {
                                        ThumbnailHeading(totalTime: 2, chapterName: " item.nameChapter", isDone: false)

                                        LazyVStack(spacing: 2) {
                                            HStack(spacing: 20) {
                                                Image(systemName: "play.rectangle.fill")
                                                    .font(.system(size: 16, weight: .regular))
                                                Text("123")
                                                Spacer()
                                                Text(convertMinutesToString(minutes: 3))
                                                    .font(.system(size: 12, weight: .regular))
                                            }
                                            .padding(20)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(hex: "#EDEDED"))
                                        }
                                    }

                                }))
                        }
                    }
                    .scrollIndicators(.never)
                }
                .padding(14)
            }
        }.toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    CircleButtonUI(isActive: false, systemName: "arrow.left", symbolRenderingMode: .multicolor)
                }).tint(.black)
            }
        }
    }
}

#Preview {
    CourseVideoPlayerView()
}
