//
//  EditUserProfileFieldView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

import SwiftUI

struct EditUserProfileFieldView: View {
    @EnvironmentObject var appData: AppData

    @State private var fullName: String = ""
    @State private var profileName: String = ""
    @State private var dateOfBirth: Date = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: "") ?? Date()
    }()

    @State private var showAlert: Bool = false
    @Binding var isShowingFieldEdit: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Full Name")) {
                    TextField("Enter full name", text: $fullName)
                        .textFieldStyle(.plain)
                }

                Section(header: Text("Profile Name")) {
                    TextField("Enter profile name", text: $profileName)
                        .textFieldStyle(.plain)
                }

                Section(header: Text("Date of Birth")) {
                    DatePicker("Select date of birth", selection: $dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
            }
            .onAppear {
                fullName = appData.userInfo?.fullName ?? ""
                profileName = appData.userInfo?.profileName ?? ""
                if let dateString = appData.userInfo?.dateOfBirth, let date = convertStringToDate(dateString) {
                    print(dateString)
                    dateOfBirth = date
                } else {
                    dateOfBirth = Date() // Provide a default value if conversion fails
                }
            }
            .background {
                Color.mainBackgroundColor
                    .ignoresSafeArea()
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(Color.mainColor3, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        withAnimation {
                            isShowingFieldEdit = false
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 34)
                                .foregroundStyle(
                                    Color.white,
                                    Color.mainColor1.gradient
                                )
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 0.1)
                                )
                                .padding(3)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                    })
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "arrow.down.to.line.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34)
                            .foregroundStyle(
                                Color.white,
                                Color.mainColor1.gradient
                            )
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 0.1)
                            )
                            .padding(3)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    .alert("Are you sure you want to save?", isPresented: $showAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Save", role: .destructive) {
                            Task {
                                try await updateUserProfile()
                            }
                        }
                    }
                }
            }
        }
        .alert(isPresented: $appData.isShowingAlert) {
            Alert(title: Text("Error"),
                  message: Text("Lỗi khi cập nhật thông tin !, vui lòng thử lại"),
                  dismissButton: .default(Text("OK")) {
                      appData.isShowingAlert = false
                  })
        }
    }

    // Helper function to convert ISO 8601 string to Date
    func convertStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter.date(from: dateString)
    }

    func updateUserProfile() async throws {
        // Chuyển đổi dateOfBirth từ Date sang String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" // Định dạng ISO 8601
        let dateOfBirthString = dateFormatter.string(from: dateOfBirth)

        let imageProfile = appData.userInfo?.profileImage ?? "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/images%2Ficon.png?alt=media&token=d3168b7f-0b84-440e-be52-fc1d59616a8d"
        let request = requestUpdateUserProfile(
            fullName: fullName,
            profileName: profileName,
            dateOfBirth: dateOfBirthString, // Sử dụng chuỗi thay vì Date
            profile_image: imageProfile
        )

        try await appData.updateUserProfile(newInfor: request, token: appData.token, userId: appData.userInfo?._id ?? "")
    }
}

#Preview {
    EditUserProfileFieldView(isShowingFieldEdit: .constant(true))
        .environmentObject(AppData())
}
