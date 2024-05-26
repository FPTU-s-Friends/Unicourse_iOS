//
//  CourseSyllabusTabView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 14/5/24.
//

import SwiftUI

struct VideoChapter: Identifiable {
    var id = UUID()
    var titleVideo: String
    var totalTime: Int

    init(id: UUID = UUID(), titleVideo: String, totalTime: Int) {
        self.id = id
        self.titleVideo = titleVideo
        self.totalTime = totalTime
    }
}

struct Mockdata: Identifiable {
    var id = UUID()
    var nameChapter: String
    var isDone: Bool
    var listVideo: [VideoChapter]

    init(nameChapter: String, isDone: Bool, listVideo: [VideoChapter]) {
        self.nameChapter = nameChapter
        self.isDone = isDone
        self.listVideo = listVideo
    }

    static var data: [Mockdata] = [
        Mockdata(nameChapter: "JPD113 buổi 1 - Spring 2022", isDone: Bool.random(),
                 listVideo: [
                     VideoChapter(titleVideo: "Video 1", totalTime: 80),
                     VideoChapter(titleVideo: "Video 2", totalTime: 90)
                 ]),
        Mockdata(nameChapter: "JPD113 buổi 2 - Spring 2022", isDone: Bool.random(),
                 listVideo: [
                     VideoChapter(titleVideo: "Video 1", totalTime: 70),
                     VideoChapter(titleVideo: "Video 2", totalTime: 90)
                 ]),
        Mockdata(nameChapter: "JPD113 buổi 3 - Spring 2022 ", isDone: Bool.random(),
                 listVideo: [
                     VideoChapter(titleVideo: "Video 1", totalTime: 70),
                     VideoChapter(titleVideo: "Video 2", totalTime: 90),
                     VideoChapter(titleVideo: "Video 3", totalTime: 90)
                 ])
    ]
}

struct CourseSyllabusTabView: View {
    var listTrack: [Track]

    private var listTrackSorted: [Track] {
        listTrack.sorted(by: { $0.position ?? 0 < $1.position ?? 1 })
    }

    var body: some View {
        VStack {
            if listTrack.isEmpty {
                VStack {
                    Text("Khoá học hiện đang được cập nhật !")
                        .font(.system(size: 12, weight: .regular))
                    Spacer()
                }
                .padding(.top, 20)
              
            } else {
                ScrollView {
                    VStack {
                        ForEach(listTrackSorted, id: \._id) { chapter in
                            ExpandableView(
                                thumbnail: ThumbnailView(content: {
                                    ThumbnailHeading(totalTime: chapter.track_steps?.reduce(0) { acc, curr in
                                        acc + curr.duration
                                    } ?? 0, chapterName: chapter.chapterTitle!, isDone: false)

                                }),
                                expanded: ExpandedView(content: {
                                    VStack {
                                        ThumbnailHeading(totalTime: chapter.track_steps?.reduce(0) { acc, curr in
                                            acc + curr.duration
                                        } ?? 0, chapterName: chapter.chapterTitle!, isDone: false)

                                        LazyVStack(spacing: 2) {
                                            ForEach(chapter.track_steps ?? [], id: \._id) { item in
                                                HStack(spacing: 20) {
                                                    Image(systemName: "play.rectangle.fill")
                                                        .font(.system(size: 16, weight: .regular))
                                                    Text(item.title)
                                                    Spacer()
                                                    Text(convertMinutesToString(minutes: item.duration))
                                                        .font(.system(size: 12, weight: .regular))
                                                }
                                                .padding(20)
                                                .frame(maxWidth: .infinity)
                                                .background(Color(hex: "#EDEDED"))
                                            }
                                        }
                                    }

                                }))
                        }
                    }
                }
                .scrollIndicators(.never)
            }
        }
    }
}

// #Preview {
//    CourseSyllabusTabView()
// }

struct ThumbnailHeading: View {
    var totalTime: Int
    var chapterName: String
    var isDone: Bool

    var body: some View {
        VStack(spacing: 11) {
            // Dynamic variable
            Text(convertMinutesToString(minutes: totalTime))
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color(hex: "#8D8A8A"))
                .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            HStack(alignment: .top, spacing: 10) {
                Image("Week")
                Text(chapterName)
                    .font(.system(size: 14, weight: .medium))
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

            HStack {
                Text(isDone ? "Đã hoàn thành" : "Chưa hoàn thành")
                    .font(.system(size: 12, weight: .medium))
                Spacer()
            }
        }
        .padding(14)
    }
}
