//
//  DetailQuizModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 3/6/24.
//

import Foundation

struct Answer: Codable {
//    var _id = UUID()
    var answer_text: String
    var is_correct: Bool
}

struct Question: Codable {
    var _id: String
    var title: String
    var type: Type_Question
    var answer: [Answer]
}

struct Creator: Codable {
    let _id: String
    let email: String
    let fullName: String
    let profileName: String
    let profile_image: String
}

struct DetailQuizModel: Codable {
    let _id: String
    let title: String
    let description: String
    let picture: String
    let course_id: String?
    let questions: [Question]
    let status: String
    let category: String
    let creator_id: Creator
    let viewer: Int
    let creator_role: String

    static let mockData = DetailQuizModel(
        _id: "663692241945fbdc90782da5",
        title: "MKT208c",
        description: "Mã môn học MKT208c",
        picture: "https://apollo.primeng.org/assets/demo/images/blog/blog-1.png",
        course_id: nil,
        questions: [
            Question(
                _id: "66367eb05159229e5baf0af6",
                title: "Which is a good starting point for writing a blog",
                type: .single,
                answer: [
                    Answer(answer_text: "Our target audience is so overwhelmed with much information, so you can start with a filter and focus blog", is_correct: true),
                    Answer(answer_text: "Our target audience is very demanding, so you should be genius to impress them", is_correct: false),
                    Answer(answer_text: "Our target audience is very smart, so try to be smarter than them", is_correct: false),
                    Answer(answer_text: "Writing blog is too traditional, it is not relevant in social marketing", is_correct: false),
                ]
            ),
            Question(
                _id: "66367eb05159229e5baf0af8",
                title: "Display ads, magazine ads, acquisition programs, endorsements, affiliate program, pay-per-click, banner ads are examples of",
                type: .single,
                answer: [
                    Answer(answer_text: "owned media", is_correct: false),
                    Answer(answer_text: "paid media", is_correct: true),
                    Answer(answer_text: "earned media", is_correct: false),
                    Answer(answer_text: "traditional media", is_correct: false),
                ]
            ),
            Question(
                _id: "66367eb05159229e5baf0afa",
                title: "In Social marketing budget, there are four areas as follows, except:",
                type: .single,
                answer: [
                    Answer(answer_text: "Empowering", is_correct: false),
                    Answer(answer_text: "Technology", is_correct: false),
                    Answer(answer_text: "Marketing program", is_correct: false),
                    Answer(answer_text: "Production", is_correct: true),
                ]
            ),
            Question(
                _id: "66367eb05159229e5baf0afc",
                title: "Which of the following are tools for Search Analytics? Check all that apply",
                type: .multiple,
                answer: [
                    Answer(answer_text: "Google Trends", is_correct: false),
                    Answer(answer_text: "Keyhole.co", is_correct: false),
                    Answer(answer_text: "Boardreader", is_correct: true),
                    Answer(answer_text: "Answer the Public", is_correct: true),
                ]
            ),
            Question(
                _id: "66367eb05159229e5baf0afe",
                title: "If you want to develop a great blog, you should avoid .......",
                type: .single,
                answer: [
                    Answer(answer_text: "Using Google Suggest for finding suitable topics", is_correct: false),
                    Answer(answer_text: "having a great headline", is_correct: false),
                    Answer(answer_text: "using images", is_correct: false),
                    Answer(answer_text: "writing a lot of long paragraphs", is_correct: true),
                ]
            ),
            // Add more questions here
        ],
        status: "open",
        category: "CN5",
        creator_id: Creator(
            _id: "65b646dade16088a25a41d68",
            email: "khainhse161766@fpt.edu.vn",
            fullName: "Nguyễn Huy Khải",
            profileName: "Embedded Software Engineer / Instructor / Blogger",
            profile_image: "https://firebasestorage.googleapis.com/v0/b/nha-trang-ntne.appspot.com/o/Unicourse%20Project%2Fuser5.jpg?alt=media&token=cfaa77cb-0586-4271-84ad-3ecd9a4f4dd4"
        ),
        viewer: 190,
        creator_role: "lecture"
    )
}
