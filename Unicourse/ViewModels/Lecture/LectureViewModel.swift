//
//  LectureViewModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 30/5/24.
//

import Foundation

class LectureViewModel: ObservableObject {
    @Published var lectureInformation: LectureDetailModel? = nil

    func getLectureById(lecture_id: String, token: String) {
        NetworkManager.shared.callAPI2(path: APILecturePath.getLectureById(lectureId: lecture_id).endPointValue, method: .get, headers: ["Authorization": "Bearer \(token)"], body: nil) {
            (result: Result<CommonResponse<LectureDetailModel>, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.lectureInformation = response.data
                    printJSONData(data: self.lectureInformation)
                }
            case .failure(let err):
                print(err)
            }
        }
    }
}
