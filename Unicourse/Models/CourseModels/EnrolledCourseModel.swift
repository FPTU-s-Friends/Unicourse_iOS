//
//  EnrolledCourseModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/5/24.
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
    var _id: Int
    var subTrackId: SubTrackId
    var completed: Bool
}

struct TrackStep: Codable {
    var _id: String
    var title: String
    var position: Int
    var duration: Int
    var content_url: String
    var type: String
}

struct TrackId: Codable {
    var _id: String
    var position: Int
    var chapterTitle: String
    var track_steps: [TrackStep]
}

struct Track: Codable {
    var _id: String
    var trackId: TrackId
    var completed: Bool
    var subTrackProgress: [SubTrackProgress]
}

struct BasicUserInfo: Codable {
    var _id: String
    var email: String
    var fullName: String
    var profileName: String
    var profile_image: String
}

struct EnrolledCourseModel: Codable {
    var _id: String
    var user: BasicUserInfo
//    var course: CourseModel
    var completed: Bool
    var enrollDate: String
    var progress: Int
//    var trackProgress: [Track]
}
