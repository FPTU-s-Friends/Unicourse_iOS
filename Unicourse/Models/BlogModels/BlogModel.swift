//
//  BlogModel.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 1/6/24.
//

import Foundation

struct BlogModel: Codable {
    let _id: String
    let title: String
    let description: String
    let min_read: Int
    let images: [String]
    let date_modified: String?
    let thumbnail_url: String
    let comment_obj: [String]
    let content: String
    let tags: [BlogTag]
    let status: String
    let flag: Bool
    let like: [String]
    let date_published: String
    let userId: BlogUserModel
    let created_at: String
    let updated_at: String

    static let sampleBlogModel = BlogModel(
        _id: "65d542d17f0cc0de60a91059",
        title: "Deploy Spring Boot cùng SQL Server lên Azure",
        description: "Microsoft Azure là nền tảng tính toán đám mây được xây dựng bởi Microsoft dành cho xây dựng, kiểm thử, triển khai và quản lý các ứng dụng và dịch vụ thông qua mạng lưới trung tâm dữ liệu được quản lý bởi Microsoft. Nó cung cấp các phần mềm, nền tảng, và hệ thống cơ sở hạ tầng như các dịch vụ hỗ trợ nhiều ngôn ngữ lập trình, framework, công cụ khác nhau.",
        min_read: 1,
        images: [],
        date_modified: "2024-02-26T04:31:55.271Z",
        thumbnail_url: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Blog%2Fblog9.png?alt=media&token=f184fcc4-48e8-4ecd-9d79-7f03a7a329f9",
        comment_obj: [
            "65deeb65dcc487b1b3f29f2b",
            "661e4dcebb0903fbb00954fd"
        ],
        content: """
        <div class="MarkdownParser_wrapper__JYN63 BlogDetail_markdownParser__QFL3L">
        <h1 class="BlogDetail_heading__DUpyK">Deploy Spring Boot c&ugrave;ng SQL Server l&ecirc;n Azure</h1>
        <h2>1.Tổng quan</h2>
        <p>Microsoft Azure l&agrave; nền tảng t&iacute;nh to&aacute;n đ&aacute;m m&acirc;y được x&acirc;y dựng bởi Microsoft d&agrave;nh cho x&acirc;y dựng, kiểm thử, triển khai v&agrave; quản l&yacute; c&aacute;c ứng dụng v&agrave; dịch vụ th&ocirc;ng qua mạng lưới trung t&acirc;m dữ liệu được quản l&yacute; bởi Microsoft. N&oacute; cung cấp c&aacute;c phần mềm, nền tảng, v&agrave; hệ thống cơ sở hạ tầng như c&aacute;c dịch vụ hỗ trợ nhiều ng&ocirc;n ngữ lập tr&igrave;nh, framework, c&ocirc;ng cụ kh&aacute;c nhau.</p>
        <p>C&aacute;c dịch vụ m&agrave; Azure cung cấp:</p>
        <ul>
        <li>Compute:</li>
        <li>Web services.</li>
        <li>Storage services.</li>
        <li>Data management.</li>
        <li>Messaging.</li>
        <li>Media services.</li>
        <li>CDN</li>
        <li>...</li>
        </ul>
        <p>Ở phần n&agrave;y m&igrave;nh sẽ giới thiệu về Web services - Azure Web Apps l&agrave; một dịch vụ x&acirc;y dựng, triển khai v&agrave; quản l&yacute; c&aacute;c ứng dụng web mạnh mẽ.</p>
        <h2>2.Đăng k&yacute; t&agrave;i khoản Azure</h2>
        <p>C&aacute;c bạn tham khảo ở link n&agrave;y :&nbsp;<a href="https://fullstack.edu.vn/external-url?continue=https%3A%2F%2Ftoidicodedao.com%2F2018%2F12%2F25%2Fcach-tao-account-microsoft-azure%2F" target="_blank" rel="noopener noreferrer">https://toidicodedao.com/2018/12/25/cach-tao-account-microsoft-azure/</a></p>
        <h2>3.C&oacute; sẵn một Spring Boot app để deploy</h2>
        <p>M&igrave;nh sẽ sử dụng một app Spring Boot cung cấp Restful API đi c&ugrave;ng với SQL Server database m&igrave;nh đ&atilde; tạo trước đ&oacute;.</p>
        <p><strong>Lưu &yacute; l&agrave; c&aacute;c bạn phải push project của c&aacute;c bạn l&ecirc;n github trước h&atilde;y thực hiện bước tiếp theo (Bắt buộc)</strong></p>
        <p><strong>Project demo (CRUD cơ bản):</strong><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0dba417146.png" alt="pj.png"></p>
        <h2>4.Deloy</h2>
        <p>Ban đầu c&aacute;c bạn v&agrave;o Azure portal v&agrave; chọn&nbsp;<strong>Create a resource</strong>.<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0d85fe99a8.png" alt="1.png">Sau đ&oacute; chọn mục&nbsp;<strong>Web App</strong>&nbsp;v&agrave;&nbsp;<strong>create</strong></p>
        <p><img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0d8d145298.png" alt="2.png">L&uacute;c n&agrave;y giao diện&nbsp;<strong>Create Web App</strong>&nbsp;sẽ hiện ra như h&igrave;nh:</p>
        <ul>
        <li>Mục số 1 : T&ecirc;n nh&oacute;m của project.</li>
        <li>Mục số 2: T&ecirc;n của web app m&igrave;nh đặt tuỳ &yacute;.</li>
        <li>Mục số 3: Ng&ocirc;n ngữ lập tr&igrave;nh ở đ&acirc;y m&igrave;nh chọn Java 8.</li>
        <li>Mục số 4:Chọn n&ecirc;n tảng ở deloy ở đ&acirc;y l&agrave; spring boot m&igrave;nh build ra file jar n&ecirc;n chọn Java SE (Embedded Web Server).</li>
        <li>Mục số 5: Ở đ&acirc;y sẽ chọn vị tr&iacute; đặt host.</li>
        <li>Mục Pricing plans: C&aacute;c bạn chọn Free F1.&nbsp;<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0d90c6e370.png" alt="3.png">Xong xu&ocirc;i rồi th&igrave; ấn&nbsp;<strong>Review + create</strong>&nbsp;<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0da9e94678.png" alt="image.png">Kiểm tra lại kỹ c&aacute;c th&ocirc;ng tin sau đ&oacute; ấn&nbsp;<strong>Create</strong>&nbsp;Đ&acirc;y l&agrave; khi tạo th&agrave;nh c&ocirc;ng.&nbsp;<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0dcb7ac6a0.png" alt="image.png">V&agrave;o&nbsp;<strong>Go to resource</strong>&nbsp;để v&agrave;o giao điện quản l&yacute;.&nbsp;<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0dd517c780.png" alt="image.png">Tiếp theo c&aacute;c bạn v&agrave;o&nbsp;<strong>Deployment Center</strong>.&nbsp;<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0ddbbbae08.png" alt="image.png">Phần source c&aacute;c bạn chọn Github sau đ&oacute; hệ thống sẽ y&ecirc;u cầu cấp quyền cho Azure sau khi cấp quyền xong th&igrave; được như h&igrave;nh. Ở phần GitHub th&igrave; c&aacute;c bạn chọn c&aacute;c th&ocirc;ng tin tương ứng với project như&nbsp;<strong>Organization, Repository, Branch</strong>.&nbsp;<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0de155c635.png" alt="image.png">Điền đầy đủ c&aacute;c th&ocirc;ng tin c&aacute;c bạn chọn save &agrave; đợi trong v&agrave;i ph&uacute;t để hệ th&ocirc;ng set up nếu ok sẽ như h&igrave;nh.&nbsp;<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0defb63303.png" alt="image.png">V&agrave;o mục log để xem trạng th&aacute;i deloy app v&agrave;o&nbsp;<strong>Build/Deploy Logs</strong>&nbsp;để xem trạng th&aacute;i.&nbsp;<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0df625189b.png" alt="image.png">Kết quả như h&igrave;nh th&igrave; l&agrave; deloy th&agrave;nh c&ocirc;ng rồi !!&nbsp;<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0dfac58304.png" alt="image.png">B&acirc;y giờ test thử xem v&agrave;o link&nbsp;<a href="https://fullstack.edu.vn/external-url?continue=https%3A%2F%2Fmycontactapi.azurewebsites.net%2Fswagger-ui.html" target="_blank" rel="noopener noreferrer">https://mycontactapi.azurewebsites.net/swagger-ui.html</a>&nbsp;<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0e052d2c9c.png" alt="image.png">V&agrave; n&oacute; đ&atilde; l&ecirc;n. B&acirc;y giờ test thử 1 method GET xem thế n&agrave;o.&nbsp;<img src="https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0e08ecf922.png" alt="image.png"> Như vậy l&agrave; ch&uacute;ng ta đ&atilde; thực hiện được c&aacute;c bước để deploy app l&ecirc;n Azure Web Apps . Ch&uacute;c c&aacute;c bạn th&agrave;nh c&ocirc;ng ! C&oacute; bất k&igrave; c&acirc;u hỏi hoặc c&acirc;u thảo luận n&agrave;o c&aacute;c bạn h&atilde;y comment b&ecirc;n dưới nh&eacute; !
        """,
        tags: [BlogTag.sampleData],
        status: "approved",
        flag: false,
        like: ["65bded46ccbed6413a0b128f"],
        date_published: "2024-02-21T00:24:49.757Z",
        userId: BlogUserModel.sampleBlogUser,
        created_at: "2024-02-21T00:24:49.759Z",
        updated_at: "2024-05-16T17:41:02.396Z"
    )
}

struct BlogTag: Codable {
    let name: String
    let code: String
    let color: String

    static let sampleData = BlogTag(name: "Thông tin", code: "thong_tin", color: "#607d8b")
}

struct BlogUserModel: Codable {
    let _id: String
    let email: String
    let fullName: String
    let profileName: String
    let profile_image: String

    static let sampleBlogUser = BlogUserModel(
        _id: "65bded46ccbed6413a0b128f",
        email: "datntse150392@fpt.edu.vn",
        fullName: "Nguyễn Thành Đạt",
        profileName: "",
        profile_image: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/images%2Fdownload.jpg?alt=media&token=27ffa58c-b776-4f6a-9492-9e48bb71e008"
    )
}
