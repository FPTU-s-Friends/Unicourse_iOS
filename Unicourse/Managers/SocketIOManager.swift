//
//  SocketIOManager.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/6/24.
//

import Foundation
import SocketIO
import SwiftUI

class SocketIOManager: ObservableObject {
    static let shared = SocketIOManager()

    private let baseURL = "https://unicourse-server-test.up.railway.app"
    // private let baseURL = "https://unicourse-api-production.up.railway.app"

    private lazy var manager = SocketManager(socketURL: URL(string: baseURL)!, config: [.log(true), .compress])
    private var socket: SocketIOClient!

    private init() {
        socket = manager.defaultSocket
        socket.on(clientEvent: .connect) { _, _ in
            print("Connected to server")
        }
        socket.connect()
    }

    func emit(event: String, data: [Any]) {
        socket.emit(event, data)
    }

    func on(event: String, callback: @escaping NormalCallback) {
        socket.on(event, callback: callback)
    }
}
