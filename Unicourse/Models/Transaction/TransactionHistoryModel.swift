//
//  TransactionHistoryModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 18/6/24.
//

struct TransactionHistoryModel: Codable {
    let _id: String
    let userId: TransactionHistoryUserModel
    let process_date: String
    let items_checkout: [TransactionHistoryItemCheckoutModel]
    let payment_method: String
    let total_old_amount: Int
    let total_new_amount: Int
    let status: String
    let total_used_coin: Int
    let transactionType: String
    let is_feedback: Bool
    let updated_at: String
    let created_at: String

    // Sample Data for TransactionHistoryModel
    static let sampleTransactionHistory = TransactionHistoryModel(
        _id: "6662bbc948fc923c73de853d",
        userId: TransactionHistoryUserModel(
            _id: "66330635e922bdb9e1b3273c",
            email: "trungkiennguyen0310@gmail.com",
            fullName: "Trung Kiên Nguyễn",
            profileName: "",
            profile_image: "https://lh3.googleusercontent.com/a/ACg8ocKOMgz_4_fRCx4kRnoKUSUewHVuVMFUTOutkoqNdqdbBqM=s96-c"
        ),
        process_date: "2024-06-07T07:50:33.591Z",
        items_checkout: [
            TransactionHistoryItemCheckoutModel(
                _id: "66544cce53646badd496cc1d",
                title: "Khóa học IOT102 - Kỳ Spring 2022",
                subTitleDescription: [
                    "Tổng hợp lại kiến thức của IOT102",
                    "Đảm bảo pass 100% khi hoàn thành khóa học",
                    "Nhận biết được các dạng câu hỏi trong bài thi"
                ],
                amount: 0,
                thumbnail: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Course%2FCN4%2FIOT102.png?alt=media&token=edc4d1f1-daff-4f28-b37b-8c03afa533b2"
            )
        ],
        payment_method: "Free",
        total_old_amount: 0,
        total_new_amount: 0,
        status: "PAID",
        total_used_coin: 0,
        transactionType: "FREE_COURSE",
        is_feedback: false,
        updated_at: "2024-06-07T07:50:33.593Z",
        created_at: "2024-06-07T07:50:33.593Z"
    )
}

struct TransactionHistoryUserModel: Codable {
    let _id: String
    let email: String
    let fullName: String
    let profileName: String
    let profile_image: String
}

struct TransactionHistoryItemCheckoutModel: Codable {
    let _id: String
    let title: String
    let subTitleDescription: [String]
    let amount: Int
    let thumbnail: String
}
