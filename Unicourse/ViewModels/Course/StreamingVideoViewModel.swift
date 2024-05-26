//
//  StreamingVideoViewModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 26/5/24.
//

import Foundation

class StreamingVideoViewModel: ObservableObject {
    @Published var selectedTrack: Track? = nil

    func setSelectedTrack(newTrack: Track) {
        selectedTrack = newTrack
    }

    func getCurrentTrack() {
        print(selectedTrack?.chapterTitle ?? "")
    }
}
