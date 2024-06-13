//
//  DailyRewardViewModel.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 10/6/24.
//

import Foundation

class DailyRewardViewModel: ObservableObject {
    @Published var dailyRewardList: [DailyRewardModel] = []
    @Published var totalCoinByUser: Int = 0
    @Published var isLoading: Bool = false
    @Published var todayDaily_Id: String = ""

    private var isLoadingDailyRewards: Bool = false {
        didSet { updateLoadingState() }
    }

    private var isLoadingTotalCoins: Bool = false {
        didSet { updateLoadingState() }
    }

    private func updateLoadingState() {
        isLoading = isLoadingDailyRewards || isLoadingTotalCoins
    }

    func getListCheckingDaily() {
        isLoadingDailyRewards = true
        NetworkManager.shared.callAPI2(path: APIDailyRewardPath.getListCheckingDaily.endPointValue, method: .get, body: nil) {
            (result: Result<CommonResponse<[DailyRewardModel]>, Error>) in
            DispatchQueue.main.async {
                self.isLoadingDailyRewards = false
                switch result {
                case .success(let response):
                    if let data = response.data {
                        self.dailyRewardList = data
                    } else {
                        self.dailyRewardList = []
                    }
                case .failure(let err):
                    print(err)
                }
            }
        }
    }

    func getTotalCoin(token: String) {
        isLoadingTotalCoins = true
        NetworkManager.shared.callAPI2(path: APIDailyRewardPath.getTotalCoin.endPointValue, method: .get, headers: ["Authorization": "Bearer \(token)"], body: nil) {
            (result: Result<CommonResponse<Int>, Error>) in
            DispatchQueue.main.async {
                self.isLoadingTotalCoins = false
                switch result {
                case .success(let response):
                    if let datas = response.data {
                        self.totalCoinByUser = datas
                    } else {
                        self.totalCoinByUser = 0
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func claimCoinToday(daily_id: String, token: String) {
        isLoading = true
        NetworkManager.shared.callAPI2(path: APIDailyRewardPath.claimCoinToday(daily_id: daily_id).endPointValue, method: .put, headers: ["Authorization": "Bearer \(token)"], body: nil) {
            (result: Result<CommonResponse<ClaimCoinResponse>, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.getListCheckingDaily()
                    self.getTotalCoin(token: token)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func isCoinClaimed(for date: String, userId: String) -> Bool {
        guard let dailyReward = dailyRewardList.first(where: { areDatesEqualIgnoringTime($0.day, date) }) else {
            return false
        }
        DispatchQueue.main.async {
            self.todayDaily_Id = dailyReward._id
        }
        return dailyReward.list_users.contains(userId)
    }

    private func compareDatesIgnoringTime(_ date1: String, _ date2: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust based on your date format
        guard let date1Parsed = dateFormatter.date(from: date1),
              let date2Parsed = dateFormatter.date(from: date2)
        else {
            return false
        }

        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: date1Parsed)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2Parsed)

        return components1 == components2
    }
}
