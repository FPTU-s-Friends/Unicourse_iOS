//
//  EnrolledCourseModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 20/5/24.
//

import Foundation

struct BasicUserInfo: Codable {
    var _id: String
    var email: String
    var fullName: String
    var profileName: String
    var profile_image: String
}

// C
struct EnrolledCourseModel: Codable {
    var _id: String
    var user: BasicUserInfo
    var course: CourseInEnrolledCoursesModel
    var completed: Bool
    var enrollDate: String
    var progress: Int
    var trackProgress: [Track]

    static var sampleData = EnrolledCourseModel(_id: "", user: BasicUserInfo(_id: "", email: "", fullName: "", profileName: "", profile_image: ""), course: CourseInEnrolledCoursesModel(_id: "", type: .free, titleDescription: "", title: "", thumbnail: "", subTitleDescription: [""], subTitle: "", enrollmentCount: 9), completed: false, enrollDate: "", progress: 76, trackProgress: [Track(_id: "", trackId: TrackId(_id: "", position: 9, chapterTitle: "", track_steps: [TrackStep(_id: "", title: "", position: 9, duration: 9, content_url: "", type: "")]), completed: false)])
}
