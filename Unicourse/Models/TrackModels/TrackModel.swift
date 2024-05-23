//
//  TrackModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 22/5/24.
//

import Foundation

struct SubTrackId: Codable {
    var _id: String
    var title: String
    var position: Int
    var duration: Int
    var content_url: String
    var type: String
}

struct SubTrackProgress: Codable {
    var _id: Int?
    var subTrackId: SubTrackId
    var completed: Bool
}

// Detail info videp của chapter
struct TrackStep: Codable {
    var _id: String
    var title: String
    var position: Int
    var duration: Int
    var content_url: String
    var type: String

    static var sampleData = TrackStep(_id: "",
                                      title: "",
                                      position: 9,
                                      duration: 9,
                                      content_url: "",
                                      type: "")
}

// Basic info video của chapter
struct Track: Codable {
    var _id: String
    var courseId: String?
    var position: Int?
    var chapterTitle: String?
    var track_steps: [TrackStep]?

    static var sampleData = Track(_id: "",
                                  position: 9,
                                  chapterTitle: "",
                                  track_steps: [TrackStep.sampleData])
}

// Chapter của khoá học
// struct Track: Codable {
//    var _id: String
//    var trackId: TrackId
//    var completed: Bool
//    //  var subTrackProgress: [SubTrackProgress]
//    // Tạm thời cần ẩn đi subtrackprogress vì database cái có
//    // cái không
//
//    static var sampleData = Track(_id: "",
//                                  trackId: TrackId.sampleData,
//                                  completed: false)
// }
