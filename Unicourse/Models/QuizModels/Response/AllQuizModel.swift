//
//  AllQuizModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 31/5/24.
//

import Foundation

struct AllQuizModel: Codable {
    var _id: String
    var title: String
    var description: String
    var picture: String
    var course_id: String?
    var questions: [String]
    var status: StatusQuiz
    var category: QuizCategory
    var creator_id: CreatorQuizModel
    var viewer: Int
    var creator_role: CreatorRole
    var created_at: String
    var updated_at: String

    static var sampleData = AllQuizModel(_id: "663692241945fbdc90782da5",
                                         title: "MKT208c",
                                         description: "Mã môn học MKT208c",
                                         picture: "https://apollo.primeng.org/assets/demo/images/blog/blog-1.png",
                                         course_id: "",
                                         questions: ["66367eb05159229e5baf0af6",
                                                     "66367eb05159229e5baf0af8",
                                                     "66367eb05159229e5baf0afa",
                                                     "66367eb05159229e5baf0afc",
                                                     "66367eb05159229e5baf0afe"],
                                         status: StatusQuiz.open,
                                         category: QuizCategory.CN1,
                                         creator_id: CreatorQuizModel(_id: "65b646dade16088a25a41d68",
                                                                      email: "khainhse161766@fpt.edu.vn",
                                                                      fullName: "Nguyễn Huy Khải",
                                                                      profileName: "Embedded Software Engineer / Instructor / Blogger",
                                                                      profile_image: "https://firebasestorage.googleapis.com/v0/b/nha-trang-ntne.appspot.com/o/Unicourse%20Project%2Fuser5.jpg?alt=media&token=cfaa77cb-0586-4271-84ad-3ecd9a4f4dd4"),
                                         viewer: 100,
                                         creator_role: .lecture,
                                         created_at: "2024-05-04T18:30:08.330Z",
                                         updated_at: "2024-05-12T09:49:40.200Z")

    var createdDate: Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = dateFormatter.date(from: created_at) else {
            print("Invalid date format: \(created_at)")
            return nil
        }
        return date
    }
}

struct CreatorQuizModel: Codable {
    var _id: String
    var email: String
    var fullName: String
    var profileName: String
    var profile_image: String
}

enum QuizCategory: String, Codable {
    case CN1
    case CN2
    case CN3
    case CN4
    case CN5
    case CN6
    case CN7
    case CN8
    case CN9
}
