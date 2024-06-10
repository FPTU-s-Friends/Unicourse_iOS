//
//  DailyRewardViewModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/6/24.
//

import Foundation

class DailyRewardViewModel: ObservableObject {
    @Published var dailyRewardList: [DailyRewardModel] = []

    func getListCheckingDaily() {
        NetworkManager.shared.callAPI2(path: APIDailyRewardPath.getListCheckingDaily.endPointValue, method: .get, body: nil) {
            (result: Result<CommonResponse<[DailyRewardModel]>, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.dailyRewardList = response.data
                }
            case .failure(let err):
                print(err)
            }
        }
    }
}
