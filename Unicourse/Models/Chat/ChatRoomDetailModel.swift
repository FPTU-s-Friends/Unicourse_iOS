//
//  ChatRoomDetailModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/6/24.
//

import Foundation

struct ChatRoomDetailModel: Codable {
    let _id: String
    let name: String
    let status: StatusChatRoom
    let memberCount: Int
    let thumbnail: String
    var users: [UserChatDetailRoomModel]
    let created_at: String
    let updated_at: String
    var messages: [MessageChatRoomDetailModel]

    static let sampleData = ChatRoomModel(
        _id: "65ebe4d2d0cb58ef9cb250cc",
        name: "Cộng đồng Unicourse",
        status: .active,
        memberCount: 8,
        thumbnail: "https://daihoc.fpt.edu.vn/wp-content/uploads/2023/04/cropped-cropped-2021-FPTU-Long.png",
        users: [.sampleData],
        created_at: "2024-03-09T04:25:54.120Z",
        updated_at: "2024-06-22T16:20:17.065Z",
        messages: [.sampleData]
    )
}

struct MessageChatRoomDetailModel: Codable, Equatable {
    let _id: String
    let user: UserDetailChatRoomDetailModel
    let message: String
    let date: String
    let status: StatusChatRoom

    static let sampleData =
        MessageChatRoomDetailModel(
            _id: "667555f58636bf875f11dc9f",
            user: .sampleData,
            message: "hello dev 1",
            date: "2024-06-21T10:29:09.890Z",
            status: .active
        )
}

struct UserChatDetailRoomModel: Codable {
    let _id: String
    let email: String
    let fullName: String
    let profileName: String
    let profile_image: String

    static let sampleData =
        UserChatRoomModel(
            _id: "665e0a8c01f6629b5005c6ec",
            email: "thanhdat.it.work@gmail.com",
            fullName: "Nguyen Thanh Dat",
            profileName: "",
            profile_image: "https://lh3.googleusercontent.com/a/ACg8ocL_iceN0ZyShgRTQdNLHte_ByaC2ddrXDVkSUR6CmpkYJDSS50=s96-c"
        )
}

struct UserDetailChatRoomDetailModel: Codable, Equatable {
    let _id: String
    let email: String
    let fullName: String
    let profileName: String
    let profile_image: String

    static let sampleData =
        UserDetailChatRoomDetailModel(
            _id: "665e0a8c01f6629b5005c6ec",
            email: "thanhdat.it.work@gmail.com",
            fullName: "Nguyen Thanh Dat",
            profileName: "",
            profile_image: "https://lh3.googleusercontent.com/a/ACg8ocL_iceN0ZyShgRTQdNLHte_ByaC2ddrXDVkSUR6CmpkYJDSS50=s96-c"
        )
}
