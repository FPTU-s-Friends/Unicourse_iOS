//
//  StreamingVideoViewModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 26/5/24.
//

import Foundation

class StreamingVideoViewModel: ObservableObject {
    @Published var selectedTrack: TrackStep? = nil

    func setSelectedTrack(newTrack: TrackStep) {
        selectedTrack = newTrack
    }

    func getCurrentTrack() {
        print(selectedTrack?.chapterTitle ?? "")
    }
}
