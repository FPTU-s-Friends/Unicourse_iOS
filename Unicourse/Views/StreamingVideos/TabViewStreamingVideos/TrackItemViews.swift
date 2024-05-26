//
//  TrackItemViews.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 26/5/24.
//

import SwiftUI

struct TrackItemViews: View {
    @ObservedObject var vm: StreamingVideoViewModel
    var track_item: Track
    var isSelected: Bool {
        vm.selectedTrack?._id == track_item._id
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Chương \(track_item.position!) - \(track_item.chapterTitle!)")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color.neutralTextColor)
                Spacer()
                Image(systemName: "book.pages")
                    .font(.system(size: 18))
                    .foregroundStyle(Color.neutralTextColor)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 15)

            ForEach(track_item.track_steps ?? [], id: \._id) { track_step in
                LazyVStack(spacing: 0) {
                    HStack {
                        HStack(spacing: 20) {
                            Text("\(track_step.position)")
                                .font(.system(size: 18, weight: isSelected ? .bold : .regular))

                            VStack(alignment: .leading, spacing: 5) {
                                Text(track_step.title)
                                    .font(.system(size: 16, weight: isSelected ? .bold : .regular))
                                Text("Độ dài video - \(convertMinutesToString(minutes: track_step.duration))")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(Color.neutralTextColor)
                            }
                        }
                        Spacer()
                        Image(systemName: "play.circle")
                            .foregroundStyle(Color.neutralTextColor)
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .background(isSelected ? Color(hex: "#eef0ff") : .white)
                }
                .onTapGesture {
                    vm.setSelectedTrack(newTrack: track_item)
                    vm.getCurrentTrack()
                }
            }
        }

        .frame(maxWidth: .infinity)
    }
}

// #Preview {
//    TrackItemViews(track_item: track_item)
// }

var track_item = Track(
    _id: "65a87e31a30979a347d026d3",
    courseId: "65a878bfa30979a347d026c6",
    position: 1,
    chapterTitle: "CSI104 Buổi 1 - Spring 2022",
    track_steps: [
        TrackStep(
            _id: "65ad100066451902420ee7b2",
            title: "Video 1",
            position: 1,
            duration: 46,
            content_url: "ajJEIBcs5A4",
            type: "video"
        ),
        TrackStep(
            _id: "65ad1000664519312420ee7b7",
            title: "Video 2",
            position: 2,
            duration: 46,
            content_url: "ajJEIBcs5A4",
            type: "video"
        )
    ]
)
