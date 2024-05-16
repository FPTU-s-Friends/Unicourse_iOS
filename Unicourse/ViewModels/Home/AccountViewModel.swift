//
//  AccountViewModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import Foundation

class AccountViewModel: ObservableObject {
    var menuItems = [
        MenuItem(id: 1, systemName: "heart.fill", title: "Yêu thích", destination: FavoriteView(), colorIcon: .red),
        MenuItem(id: 2, systemName: "clock.fill", title: "Xem gần nhất", destination: RecentView(), colorIcon: .blue),
        MenuItem(id: 3, systemName: "sportscourt.fill", title: "Mã giảm giá", destination: DiscountView(), colorIcon: .orange),
        MenuItem(id: 4, systemName: "basket.fill", title: "Lịch sử giao dịch", destination: TransactionHistoryView(), colorIcon: .colorCartIcon),
    ]
}
