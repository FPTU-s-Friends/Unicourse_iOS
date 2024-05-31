//
//  LectureInfoView.swift
//  Unicourse
//
//  Created by Minh Trần Quang on 30/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct LectureInfoView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss: DismissAction
    @StateObject private var vm = LectureViewModel()
    var lecture_id: String

    @State private var showMore = false

    private let description = "Tại Unicourse, chúng tôi tự hào giới thiệu một đội ngũ giảng viên đa dạng và giàu kinh nghiệm, đồng lòng với mục tiêu tạo ra một môi trường học tập đầy sáng tạo và chất lượng cao. Với sự đa dạng về lĩnh vực chuyên môn và nền tảng giáo dục, các giảng viên của chúng tôi mang đến."

    var body: some View {
        VStack {
            ScrollView {
                if vm.isLoading {
                    SkeletonLectureDetail()
                } else {
                    HStack(alignment: .top, spacing: 20) {
                        if let urlString = vm.lectureInformation?.profile_image, let url = URL(string: urlString) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 70, height: 70)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                case .failure:
                                    Image(.defaultProfile)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                @unknown default:
                                    Image(.defaultProfile)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                }
                            }
                        } else {
                            Image(.defaultProfile)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                        }

                        VStack(alignment: .leading) {
                            Text(vm.lectureInformation?.fullName ?? "")
                                .font(.system(size: 22, weight: .bold))
                                .bold()
                            HStack(alignment: .center) {
                                Image(systemName: "envelope.fill")
                                Text(vm.lectureInformation?.email ?? "")
                                    .font(.system(size: 14))
                            }
                            .font(.system(size: 14))
                            .foregroundStyle(Color.neutralTextColor)
                            .tint(Color.neutralTextColor)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 20)

                    HStack(spacing: 40) {
                        VStack {
                            Text("Học viên")
                                .font(.system(size: 14, weight: .bold))
                            Text("200")
                                .font(.system(size: 18, weight: .bold))
                        }
                        VStack {
                            Text("Đánh giá")
                                .font(.system(size: 14, weight: .bold))
                            Text("200")
                                .font(.system(size: 18, weight: .bold))
                        }
                        Spacer()
                    }
                    .padding(.bottom, 20)

                    VStack {
                        HStack {
                            Text("Về giảng viên")
                                .font(.system(size: 18, weight: .bold))
                            Spacer()
                        }

                        if vm.lectureInformation?.lecture_info?.description.isEmpty == false {
                            VStack(alignment: .leading) {
                                Text(vm.lectureInformation?.lecture_info?.description ?? "")
                                    .font(.system(size: 14, weight: .light))
                                    .lineLimit(showMore ? nil : 5)
                                    .background(GeometryReader { geo in
                                        Color.clear.onAppear {
                                            if geo.size.height > 90 {
                                                showMore = false
                                            }
                                        }
                                    })
                                    .frame(height: showMore ? nil : 90)

                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        showMore.toggle()
                                    }
                                }) {
                                    Text(showMore ? "Thu nhỏ" : "Xem thêm")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.blue)
                                }
                            }
                        } else {
                            Text("Giảng viên hiện chưa cập nhật mô tả !")
                                .font(.system(size: 14, weight: .light))
                                .padding(.vertical, 20)
                        }
                    }
                    .padding(.bottom, 20)

                    VStack {
                        HStack {
                            Text("Khoá học của tôi (\(vm.lectureInformation?.lecture_info?.my_course?.count ?? 0))")
                                .font(.system(size: 18, weight: .bold))
                            Spacer()
                        }
                        if (vm.lectureInformation?.lecture_info?.my_course?.isEmpty) == nil || vm.lectureInformation?.lecture_info?.my_course?.count == 0 {
                            NotfoundView(systemName: "shippingbox.fill", message: "Giảng viên này chưa có khoá học nào !")
                        } else {
                            ForEach(vm.lectureInformation?.lecture_info?.my_course ?? [], id: \._id) { item in
                                MyCourseLectureItem(course: item, lecture_name: vm.lectureInformation?.fullName ?? " ")
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .navigationTitle("Giảng viên")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                }
            }
        }
        .onAppear {
            vm.getLectureById(lecture_id: lecture_id, token: appData.token)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        LectureInfoView(lecture_id: "662f61f6b57741e90fac0a5b")
            .environmentObject(AppData())
    }
}
