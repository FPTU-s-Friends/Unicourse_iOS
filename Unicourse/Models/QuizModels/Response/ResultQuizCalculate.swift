//
//  ResultQuizCalculate.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 18/6/24.
//

import Foundation

struct QuestionResponseResult: Codable {
    var _id: String
    var title: String
    var type: Type_Question
    var is_answered: Bool
    var answer: [AnswerRequest]
    var user_correct: Bool
}

struct ResultQuizCalculate: Codable {
    var _id: String
    var title: String
    var description: String
    var picture: String
    var course_id: String?
    var questions: [QuestionResponseResult]
    var status: String
    var category: String
    var creator_id: Creator
    var viewer: Int
    var creator_role: String
    var number_right_answer: Int

    static let mockData = ResultQuizCalculate(
        _id: "663692241945fbdc90782da5",
        title: "MKT208c",
        description: "Mã môn học MKT208c",
        picture: "https://apollo.primeng.org/assets/demo/images/blog/blog-1.png",
        course_id: nil,
        questions: [
            QuestionResponseResult(
                _id: "66367eb05159229e5baf0af6",
                title: "Which is a good starting point for writing a blog",
                type: .single,
                is_answered: true,
                answer: [
                    AnswerRequest(answer_text: "Our target audience is so overwhelmed with much information, so you can start with a filter and focus blog", is_correct: true, is_checked: true, is_answered: false),
                    AnswerRequest(answer_text: "Our target audience is very demanding, so you should be genius to impress them", is_correct: false, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "Our target audience is very smart, so try to be smarter than them", is_correct: false, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "Writing blog is too traditional, it is not relevant in social marketing", is_correct: false, is_checked: false, is_answered: false)
                ],
                user_correct: true
            ),
            QuestionResponseResult(
                _id: "66367eb05159229e5baf0af8",
                title: "Display ads, magazine ads, acquisition programs, endorsements, affiliate program, pay-per-click, banner ads are examples of",
                type: .single,
                is_answered: true,
                answer: [
                    AnswerRequest(answer_text: "owned media", is_correct: false, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "paid media", is_correct: true, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "earned media", is_correct: false, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "traditional media", is_correct: false, is_checked: true, is_answered: false)
                ],
                user_correct: false
            ),
            QuestionResponseResult(
                _id: "66367eb05159229e5baf0afa",
                title: "In Social marketing budget, there are four areas as follows, except:",
                type: .single,
                is_answered: true,
                answer: [
                    AnswerRequest(answer_text: "Empowering", is_correct: false, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "Technology", is_correct: false, is_checked: true, is_answered: false),
                    AnswerRequest(answer_text: "Marketing program", is_correct: false, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "Production", is_correct: true, is_checked: false, is_answered: false)
                ],
                user_correct: false
            ),
            QuestionResponseResult(
                _id: "66367eb05159229e5baf0afc",
                title: "Which of the following are tools for Search Analytics? Check all that apply",
                type: .multiple,
                is_answered: true,
                answer: [
                    AnswerRequest(answer_text: "Google Trends", is_correct: true, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "Keyhole.co", is_correct: false, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "Boardreader", is_correct: true, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "Answer the Public", is_correct: true, is_checked: true, is_answered: false)
                ],
                user_correct: false
            ),
            QuestionResponseResult(
                _id: "66367eb05159229e5baf0afe",
                title: "If you want to develop a great blog, you should avoid .......",
                type: .single,
                is_answered: true,
                answer: [
                    AnswerRequest(answer_text: "Using Google Suggest for finding suitable topics", is_correct: false, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "having a great headline", is_correct: false, is_checked: true, is_answered: false),
                    AnswerRequest(answer_text: "using images", is_correct: false, is_checked: false, is_answered: false),
                    AnswerRequest(answer_text: "writing a lot of long paragraphs", is_correct: true, is_checked: false, is_answered: false)
                ],
                user_correct: false
            )
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
        viewer: 198,
        creator_role: "lecture",
        number_right_answer: 1
    )
}
