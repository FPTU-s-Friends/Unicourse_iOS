//
//  CourseVideoPlayerView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 17/5/24.
//

import SwiftUI

struct CourseVideoPlayerView: View {
    let listTrack: [Track]
    let title: String
    @StateObject var vm = StreamingVideoViewModel()
    @State private var tabSelection = 0
    @State private var videoIndex: Int = 1
    @State private var isAnimating = false
    @State private var isOpenGemini = false
    private var listTrackSorted: [Track] {
        listTrack.sorted(by: { ($0.position ?? 0) < ($1.position ?? 0) })
    }

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // Stream view
                    VStack {
                        VideoStreamingView(videoID: vm.selectedTrack?.content_url ?? "")
                    }
                    .frame(maxWidth: .infinity, minHeight: geometry.size.height * 0.3)
                    .background(.gray.opacity(0.2))

                    // Head  title
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 10) {
                            // Chapter     Title
                            Text(vm.selectedTrack?.chapterTitle ?? "")
                                .font(.system(size: 16, weight: .semibold))
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                            // Video Title
                            HStack {
                                Image(systemName: "play.rectangle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16)
                                    .foregroundStyle(Color.red)
                                Text(vm.selectedTrack?.title ?? "")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                            }
                            .font(.system(size: 14, weight: .regular))

                            HStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 14)
                                    .foregroundStyle(Color.UIButtonGreen)
                                Text("Giảng viên:")
                                Text("Giảng viên Unicourse")
                            }
                            .font(.system(size: 14, weight: .regular))
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

                    Spacer(minLength: 30)

                    // Tab view: [Danh sách phát, Thảo luận]
                    VStack {
                        TabSelectionView(tabSelection: $tabSelection, selectionButtons: ["Danh sách phát", "Thảo luận"])
                        Divider()

                        TabView(selection: $tabSelection) {
                            ScrollView {
                                VStack {
                                    ForEach(listTrackSorted, id: \._id) { track_item in
                                        TrackItemViews(vm: vm, track_item: track_item)
                                    }
                                }
                            }
                            .padding(.bottom, 30)
                            .tag(0)

                            VStack {
                                Text("Đang cập nhật...")
                            }
                            .tag(1)
                        }
                        .frame(height: geometry.size.height * 0.55)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
                .frame(maxHeight: .infinity)
                .sheet(isPresented: $isOpenGemini) {
                    GeminiPromptView(isOpenGemini: $isOpenGemini)
                        .presentationDetents([.large])
                        .presentationCornerRadius(30)
                        .interactiveDismissDisabled()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        ButtonBackUIView()
                    }
                }
                .onAppear {
                    if !listTrack.isEmpty {
                        vm.selectedTrack = listTrack[0].track_steps![0]
                    }
                }
            }

            ButtonDragUIView()
                .onTapGesture {
                    withAnimation(.spring) {
                        isOpenGemini = true
                    }
                }
        }
    }
}

#Preview {
    NavigationStack {
        CourseVideoPlayerView(listTrack: mockData, title: "Khóa học CSI104")
    }
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
