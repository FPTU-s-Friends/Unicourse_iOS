//
//  CourseVideoPlayerView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 17/5/24.
//

import SwiftUI

struct CourseVideoPlayerView: View {
//    @Environment(\.dismiss) var dismiss
    let listTrack: [Track]
    @StateObject var vm = StreamingVideoViewModel()
    @State private var tabSelection = 0

    var body: some View {
        VStack(spacing: 0) {
            // Stream view
            VStack {
//                VideoStreamingView(videoID: "cizoIav3geY")
            }
            .frame(maxWidth: .infinity, minHeight: 250)
            .background(.gray.opacity(0.2))

            // Tab view
            ScrollView {
                // Head title
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        // Chapter Title 
                        Text("CSI104 Buổi 10 - Spring 2022")
                            .font(.system(size: 18, weight: .semibold))
                        // Video Title
                        HStack {
                            Image(systemName: "play.rectangle")
                            Text("Đang phát:")
                            Text("Video 1")

                        }.font(.system(size: 15, weight: .regular))

                        HStack {
                            Image(systemName: "person.fill")
                            Text("Giảng viên:")
                            Text("Giảng viên Unicourse")

                        }.font(.system(size: 15, weight: .regular))
                    }
                    Spacer()
                    Button {} label: {
                        Image(systemName: "bookmark.square.fill")
                            .symbolRenderingMode(.hierarchical)
                            .font(.system(size: 40))
                            .foregroundStyle(.blue)
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)

                // End Head Title

                Spacer(minLength: 30)

                // Tab view: [Danh sách phát, More]
                VStack {
                    TabSelectionView(tabSelection: $tabSelection, selectionButtons: ["Danh sách phát", "Thảo luận"])
                    Divider()

                    TabView(selection: $tabSelection) {
                        VStack {
                            Text("\(listTrack.count)")
                        }.tag(0)

                        VStack {
                            Text("Tab2")
                        }.tag(1)
                    }
                    .frame(height: 400)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .padding(.bottom, 70)
                }
            }
            Spacer()
        }
        .onAppear {
            if !listTrack.isEmpty {
                vm.selectedTrack = listTrack[0]
            }
        }
    }
}

#Preview {
    CourseVideoPlayerView(listTrack: mockData)
}

// Create mock data
let mockData: [Track] = [
    Track(
        _id: "65a87e31a30979a347d026d3",
        courseId: "65a878bfa30979a347d026c6",
        position: 1,
        chapterTitle: "CSI104 Buổi 1 - Spring 2022",
        track_steps: [
            TrackStep(
                _id: "65ad100066451902420ee7b7",
                title: "Video 1",
                position: 1,
                duration: 46,
                content_url: "ajJEIBcs5A4",
                type: "video"
            )
        ]
    ),
    Track(
        _id: "65aa4d443cce807fe880c22e",
        courseId: "65a878bfa30979a347d026c6",
        position: 10,
        chapterTitle: "CSI104 Buổi 10 - Spring 2022",
        track_steps: [
            TrackStep(
                _id: "65ad100066451902420ee7ca",
                title: "Video 1",
                position: 1,
                duration: 45,
                content_url: "h-39pz6DpDg",
                type: "video"
            )
        ]
    ),
    Track(
        _id: "65aa4dce3cce807fe880c22f",
        courseId: "65a878bfa30979a347d026c6",
        position: 11,
        chapterTitle: "CSI104 Buổi 11 - Spring 2022",
        track_steps: [
            TrackStep(
                _id: "65ad100066451902420ee7cb",
                title: "Video 1",
                position: 1,
                duration: 70,
                content_url: "PkAm174VxJ4",
                type: "video"
            )
        ]
    )
]
