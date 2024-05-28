//
//  EnrolledNewCourseModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 28/5/24.
//

import Foundation

struct EnrolledNewCourseModelCourse: Codable {
    let _id: String
    let title: String
    let titleDescription: String
    let subTitle: String
    let subTitleDescription: [String]
    let thumbnail: String
}

struct EnrolledNewCourseModelUser: Codable {
    let _id: String
    let email: String
}

struct EnrolledNewCourseModel: Codable {
    let _id: String
    let user: EnrolledNewCourseModelUser
    let course: EnrolledNewCourseModelCourse
    let progress: Int
    let enrollDate: String
    let completed: Bool
    let trackProgress: [TrackProgress]
}
