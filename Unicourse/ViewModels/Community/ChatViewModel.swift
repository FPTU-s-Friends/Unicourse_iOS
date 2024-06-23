//
//  ChatViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 23/6/24.
//
import Foundation

class ChatViewModel: ObservableObject {
    @Published var chatRoomDetail: ChatRoomDetailModel?
    @Published var isLoadingChatRoom = false
    @Published var error = ""
    @Published var isShowingAlert = false

    func getDetailChatRoom(roomId: String) async throws {
        let path = APIPath.getChatRooms.stringValue
        let method = HTTPMethod.get

        do {
            let response: CommonResponse<ChatRoomDetailModel> = try await NetworkManager.shared.callAPI(path: "\(path)/\(roomId)", method: method, body: nil)
            printJSONData(data: response)
            if let data = response.data {
                chatRoomDetail = data
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

    func sendMessage(_ message: String, by userId: String) {}
}
