//
//  AccountMenuView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct AccountMenuView: View {
    @EnvironmentObject var appData: AppData
    @Binding var menuItems: [MenuItem]
    @State private var showAlert = false
    @State private var isLoggedOut = false

    var body: some View {
        VStack {
            ForEach(menuItems) { menuItem in
                NavigationLink(destination: menuItem.destination) {
                    VStack {
                        if menuItem.id == 2 {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: menuItem.systemName)
                                        .foregroundStyle(menuItem.colorIcon)
                                    Text(menuItem.title)
                                        .foregroundStyle(.black)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image("arrow-right")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 25, height: 25)
                                }

                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(1 ..< 3) { _ in
                                            HStack {
                                                Image("3diconsiconcourse")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 55, height: 55)
                                                    .cornerRadius(10)

                                                Text("MAD101 - Toán rời rạc")
                                                    .font(.system(size: .mainTitlePath, weight: .bold))
                                                    .foregroundStyle(.black)
                                                    .multilineTextAlignment(.leading)
                                            }
                                            .frame(width: 200, height: 70)
                                            .padding(3)
                                            .background(Color.grayItem.cornerRadius(10))
                                        }
                                    }
                                }
                                .frame(height: 100)
                            }

                        } else {
                            HStack {
                                Image(systemName: menuItem.systemName)
                                    .foregroundStyle(menuItem.colorIcon)
                                Text(menuItem.title)
                                    .foregroundStyle(.black)
                                    .fontWeight(.semibold)
                                Spacer()
                                Image("arrow-right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 25, height: 25)
                            }
                        }

                        Divider()
                    }
                    .padding(.top, 10)
                }
            }

            Button {
                showAlert = true // Hiển thị Alert khi người dùng nhấn vào nút
            } label: {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                        .foregroundStyle(.red)
                    Text("Đăng xuất")
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.leading, 2)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Xác nhận"),
                    message: Text("Bạn có chắc chắn muốn đăng xuất không?"),
                    primaryButton: .destructive(Text("Có")) {
                        SignOut()
                    },
                    secondaryButton: .cancel(Text("Không"))
                )
            }
            .fullScreenCover(isPresented: $isLoggedOut, content: {
                ContentView()
            })
        }
        .padding(.horizontal, 40)
    }

    func SignOut() {
        Task {
            do {
                appData.isLoading = true
                try AuthenticationManager.shared.signOut()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    appData.signOutUser()
                }
            } catch {
                appData.showAlert(text: error.localizedDescription)
            }
            do {
                appData.isLoading = false
            }
        }
    }
}

#Preview {
    AccountMenuView(menuItems: .constant(AccountViewModel().menuItems))
}
