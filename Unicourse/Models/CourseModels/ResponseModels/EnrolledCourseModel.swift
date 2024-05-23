//
//  EnrolledCourseModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/5/24.
//

import Foundation

// C
struct EnrolledCourseModel: Codable {
    var _id: String
    var user: BasicUserInfo
    var course: CourseModel?
    var completed: Bool
    var enrollDate: String
    var progress: Int
    var trackProgress: [Track]

    static var sampleData = EnrolledCourseModel(_id: "",
                                                user: BasicUserInfo(_id: "", email: "", fullName: "", profileName: "", profile_image: ""),
                                                course: CourseModel.sampleData,
                                                completed: false,
                                                enrollDate: "",
                                                progress: 76,
                                                trackProgress: [Track(_id: "", trackId: TrackId.sampleData, completed: false)])
}

struct BasicUserInfo: Codable {
    var _id: String
    var email: String
    var fullName: String
    var profileName: String
    var profile_image: String

    static var sampleData = BasicUserInfo(_id: "", email: "", fullName: "", profileName: "", profile_image: "")
}
