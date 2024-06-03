//
//  DetailQuizModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 3/6/24.
//

import Foundation

struct Answer: Codable {
    var _id = UUID()
    var answerText: String
    var isCorrect: Bool
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

    static let mockData = [
        DetailQuizModel(
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
                        Answer(answerText: "Our target audience is so overwhelmed with much information, so you can start with a filter and focus blog", isCorrect: true),
                        Answer(answerText: "Our target audience is very demanding, so you should be genius to impress them", isCorrect: false),
                        Answer(answerText: "Our target audience is very smart, so try to be smarter than them", isCorrect: false),
                        Answer(answerText: "Writing blog is too traditional, it is not relevant in social marketing", isCorrect: false),
                    ]
                ),
                Question(
                    _id: "66367eb05159229e5baf0af8",
                    title: "Display ads, magazine ads, acquisition programs, endorsements, affiliate program, pay-per-click, banner ads are examples of",
                    type: .single,
                    answer: [
                        Answer(answerText: "owned media", isCorrect: false),
                        Answer(answerText: "paid media", isCorrect: true),
                        Answer(answerText: "earned media", isCorrect: false),
                        Answer(answerText: "traditional media", isCorrect: false),
                    ]
                ),
                Question(
                    _id: "66367eb05159229e5baf0afa",
                    title: "In Social marketing budget, there are four areas as follows, except:",
                    type: .single,
                    answer: [
                        Answer(answerText: "Empowering", isCorrect: false),
                        Answer(answerText: "Technology", isCorrect: false),
                        Answer(answerText: "Marketing program", isCorrect: false),
                        Answer(answerText: "Production", isCorrect: true),
                    ]
                ),
                Question(
                    _id: "66367eb05159229e5baf0afc",
                    title: "Which of the following are tools for Search Analytics? Check all that apply",
                    type: .multiple,
                    answer: [
                        Answer(answerText: "Google Trends", isCorrect: false),
                        Answer(answerText: "Keyhole.co", isCorrect: false),
                        Answer(answerText: "Boardreader", isCorrect: true),
                        Answer(answerText: "Answer the Public", isCorrect: true),
                    ]
                ),
                Question(
                    _id: "66367eb05159229e5baf0afe",
                    title: "If you want to develop a great blog, you should avoid .......",
                    type: .single,
                    answer: [
                        Answer(answerText: "Using Google Suggest for finding suitable topics", isCorrect: false),
                        Answer(answerText: "having a great headline", isCorrect: false),
                        Answer(answerText: "using images", isCorrect: false),
                        Answer(answerText: "writing a lot of long paragraphs", isCorrect: true),
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
        ),
    ]
}
