//
//  CommunityViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/6/24.
//

import Foundation

class CommunityViewModel: ObservableObject {
    @Published var searchString: String = ""
    @Published var gradientHeight: CGFloat = 0
    @Published var isPresentedCreateGroup = false

    @Published var allChatRooms: [ChatRoomModel] = []
    @Published var isLoadingChatRoom = false
    @Published var error = ""
    @Published var isShowingAlert = false

    func getAllChatRooms() async throws {
        let path = APIPath.getChatRooms.stringValue
        let method = HTTPMethod.get

        do {
            let response: CommonResponse<[ChatRoomModel]> = try await NetworkManager.shared.callAPI(path: path, method: method, body: nil)
            if let data = response.data {
                allChatRooms = data
            } else {
                isShowingAlert = true
                error = "Data trả về rỗng!"
            }
        } catch {
            print("Get All Chat Rooms Error", error)
            isShowingAlert = true
            self.error = "Không tìm thấy phòng chat nào! vui lòng thử lại hoặc reload lại!"
        }
    }
}
