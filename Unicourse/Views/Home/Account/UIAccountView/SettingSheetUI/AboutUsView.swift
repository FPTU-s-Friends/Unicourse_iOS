//
//  AboutUsView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

import SwiftUI

struct AboutUsView: View {
    @Environment(\.presentationMode) var presentationMode // Use environment to control view dismissal

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Image("appIcon") // Ensure this image exists in your assets
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding(.top, 20)

                    Image("uni1") // Ensure this image exists in your assets
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                        .padding(.horizontal, 5)

                    introductionSection
                    missionSection
                    startupJourneySection
                    challengesSection

                    // Unicourse Members Section
                    unicourseMembersSection

                    // Contact Us Section
                    contactUsSection

                    // Visit Us Section
                    visitUsSection
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Giới thiệu")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ButtonCircleUIView(systemName: "arrow.left.circle.fill") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    private var introductionSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Với tầm nhìn trở thành nền tảng học tập trực tuyến hàng đầu tại Việt Nam, Unicourse đặt ra những mục tiêu đầy tham vọng cho tương lai. Trong ngắn hạn, nền tảng hướng đến việc tăng số lượng người dùng, mở rộng đối tượng khách hàng và phát triển trên nhiều nền tảng khác nhau. Về dài hạn, Unicourse mong muốn xây dựng lộ trình học tập cho nhiều ngành nghề khác nhau, mở rộng ra các trường đại học trên toàn quốc và thậm chí là xây dựng văn phòng đại diện riêng.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 20)
    }

    private var missionSection: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("Dự án Unicourse: Nền tảng học tập trực tuyến nhận Học bổng Khởi nghiệp từ Trường Đại Học FPT")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Với tầm nhìn trở thành nền tảng học tập trực tuyến hàng đầu tại Việt Nam, Unicourse đặt ra những mục tiêu đầy tham vọng cho tương lai. Trong ngắn hạn, nền tảng hướng đến việc tăng số lượng người dùng, mở rộng đối tượng khách hàng và phát triển trên nhiều nền tảng khác nhau. Về dài hạn, Unicourse mong muốn xây dựng lộ trình học tập cho nhiều ngành nghề khác nhau, mở rộng ra các trường đại học trên toàn quốc và thậm chí là xây dựng văn phòng đại diện riêng.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }

    private var startupJourneySection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Hành trình nhận học bổng khởi nghiệp")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Để biến ý tưởng thành hiện thực, nhóm đã không ngừng nỗ lực hoàn thiện dự án và mạnh dạn ứng tuyển Học bổng Khởi nghiệp của trường. Nhờ sự chuẩn bị kỹ lưỡng và tiềm năng phát triển của dự án, Unicourse đã được trao học bổng trị giá hơn 30 triệu đồng, tạo động lực lớn để nhóm tiếp tục phát triển nền tảng.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 20)
    }

    private var challengesSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Thách thức khi thực hiện dự án và giải pháp")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Unicourse áp dụng mô hình Lean Startup, tập trung vào việc nhanh chóng tung ra sản phẩm tối giản và liên tục cải tiến dựa trên phản hồi của người dùng. Đối tượng khách hàng chính của nền tảng là sinh viên, với nguồn doanh thu đến từ việc bán khóa học và chia sẻ hoa hồng với giảng viên. Để thu hút và giữ chân khách hàng, Unicourse đã triển khai nhiều chiến lược như tổ chức minigame, tạo nội dung chất lượng, giảm giá cho khách hàng mới và xây dựng chương trình khách hàng thân thiết.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 20)
    }

    private var unicourseMembersSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Thành viên dự án Unicourse")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal, 20)

            // Grid layout for members
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                memberView(name: "Đặng Minh Châu", title: "Chief Executive Officer", imageName: "chau")
                memberView(name: "Nguyễn Thành Đạt", title: "Chief Technology Officer", imageName: "dat")
                memberView(name: "Nguyễn Huy Khải", title: "Chief Financial Officer", imageName: "khai")
                memberView(name: "Mạc Tuấn Long", title: "Chief Marketing Officer", imageName: "long")
                memberView(name: "Đinh Gia Bảo", title: "Backend Developer", imageName: "bao")
                memberView(name: "Bùi Đức Trí", title: "Backend Developer", imageName: "tri")
                memberView(name: "Nguyễn Trung Kiên", title: "Mobile Developer", imageName: "kien")
                memberView(name: "Trần Quang Minh", title: "Mobile Developer", imageName: "minh")
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 20)
    }

    private var contactUsSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Image("contactUsImage") // Ensure this image exists in your assets
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 5)

            Text("Liên hệ với chúng tôi")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Bạn có bất kỳ câu hỏi hoặc phản hồi nào? Chúng tôi rất mong nhận được phản hồi từ bạn! Hãy liên hệ với chúng tôi tại ")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .foregroundColor(.blue)
                .underline()

            Text("[unicourse.learningplatform@gmail.com](mailto:unicourse.learningplatform@gmail.com)")
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
    }

    private var visitUsSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Thêm thông tin")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.leading, 5)

            Text("Để biết thêm thông tin, hãy truy cập trang web của chúng tôi tại ")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .foregroundColor(.blue)
                .underline()
                .padding(.horizontal, 5)

            Text("[unicourse.vn](https://unicourse.vn)")
                .padding(.leading, 5)
        }
    }

    // Helper View to create member profile
    private func memberView(name: String, title: String, imageName: String) -> some View {
        VStack {
            Image(imageName) // Ensure this image exists in your assets
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(radius: 5)

            Text(name)
                .font(.headline)
                .multilineTextAlignment(.center)

            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
