//
//  PrintDataJSON.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 24/5/24.
//

import SwiftUI
import SwiftyJSON

func printJSONData<T: Encodable>(data: T) {
    do {
        let jsonData = try JSONEncoder().encode(data)
        if let jsonString = try JSON(data: jsonData).rawString() {
            print(jsonString)
        } else {
            print("Failed to convert data to JSON string")
        }
    } catch {
        print("Error encoding data to JSON: \(error)")
    }
}
