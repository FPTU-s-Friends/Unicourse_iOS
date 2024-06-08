//
//  FavoriteView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss: DismissAction
    @State var searchString: String = ""
    @State private var isSearchBarVisible: Bool = false

    var body: some View {
        VStack {
            if let wishList = appData.userInfo?.wishList, !wishList.isEmpty {
                List {
                    ForEach(appData.userInfo?.wishList ?? [], id: \._id) { wistItem in
                        //
                        FavoriteItemView(wishItem: wistItem)
                            .background(Color.white.cornerRadius(10))
                            .swipeActions {
                                Button(role: .destructive) {
                                    withAnimation {}
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                            .tint(.red)
                    }
                }
                .searchable(text: $searchString, isPresented: $isSearchBarVisible, prompt: Text("Tìm kiếm"))
                .padding(.horizontal, -5)
                .background(Color.mainBackgroundColor)
                .listStyle(.insetGrouped)
            } else {
                NotfoundView(systemName: "shippingbox.fill", message: "Bạn chưa có yêu thích khoá học nào")
                Spacer()
            }
        }

        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonBackUIView()
            }

            ToolbarItem(placement: .topBarTrailing) {
                ButtonSearchUIView(isSearchOpen: $isSearchBarVisible)
            }
        }
    }
}

#Preview {
    NavigationStack {
        FavoriteView()
    }
}
