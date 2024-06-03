//
//  WebView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var htmlContent: String
    @Binding var webViewHeight: CGFloat

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let html = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
        body {
            font-family: -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
            font-size: 14px;
            margin: 0;
            padding: 0;
            background-color: #F3FBFF;
            padding: 10px;
        }
        h1, h2, h3 {
            color: "#5EDFF5";
        }
        img {
            max-width: 95%;
            height: auto;
        }
        </style>
        </head>
        <body>
        \(htmlContent)
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.body.scrollHeight") { height, _ in
                if let height = height as? CGFloat {
                    DispatchQueue.main.async {
                        self.parent.webViewHeight = height
                    }
                }
            }
        }
    }
}

#Preview {
    WebView(htmlContent: "<div class=\"MarkdownParser_wrapper__JYN63 BlogDetail_markdownParser__QFL3L\">\n<h1 class=\"BlogDetail_heading__DUpyK\">Deploy Spring Boot c&ugrave;ng SQL Server l&ecirc;n Azure</h1>\n<h2>1.Tổng quan</h2>\n<p>Microsoft Azure l&agrave; nền tảng t&iacute;nh to&aacute;n đ&aacute;m m&acirc;y được x&acirc;y dựng bởi Microsoft d&agrave;nh cho x&acirc;y dựng, kiểm thử, triển khai v&agrave; quản l&yacute; c&aacute;c ứng dụng v&agrave; dịch vụ th&ocirc;ng qua mạng lưới trung t&acirc;m dữ liệu được quản l&yacute; bởi Microsoft. N&oacute; cung cấp c&aacute;c phần mềm, nền tảng, v&agrave; hệ thống cơ sở hạ tầng như c&aacute;c dịch vụ hỗ trợ nhiều ng&ocirc;n ngữ lập tr&igrave;nh, framework, c&ocirc;ng cụ kh&aacute;c nhau.</p>\n<p>C&aacute;c dịch vụ m&agrave; Azure cung cấp:</p>\n<ul>\n<li>Compute:</li>\n<li>Web services.</li>\n<li>Storage services.</li>\n<li>Data management.</li>\n<li>Messaging.</li>\n<li>Media services.</li>\n<li>CDN</li>\n<li>...</li>\n</ul>\n<p>Ở phần n&agrave;y m&igrave;nh sẽ giới thiệu về Web services - Azure Web Apps l&agrave; một dịch vụ x&acirc;y dựng, triển khai v&agrave; quản l&yacute; c&aacute;c ứng dụng web mạnh mẽ.</p>\n<h2>2.Đăng k&yacute; t&agrave;i khoản Azure</h2>\n<p>C&aacute;c bạn tham khảo ở link n&agrave;y :&nbsp;<a href=\"https://fullstack.edu.vn/external-url?continue=https%3A%2F%2Ftoidicodedao.com%2F2018%2F12%2F25%2Fcach-tao-account-microsoft-azure%2F\" target=\"_blank\" rel=\"noopener noreferrer\">https://toidicodedao.com/2018/12/25/cach-tao-account-microsoft-azure/</a></p>\n<h2>3.C&oacute; sẵn một Spring Boot app để deploy</h2>\n<p>M&igrave;nh sẽ sử dụng một app Spring Boot cung cấp Restful API đi c&ugrave;ng với SQL Server database m&igrave;nh đ&atilde; tạo trước đ&oacute;.</p>\n<p><strong>Lưu &yacute; l&agrave; c&aacute;c bạn phải push project của c&aacute;c bạn l&ecirc;n github trước h&atilde;y thực hiện bước tiếp theo (Bắt buộc)</strong></p>\n<p><strong>Project demo (CRUD cơ bản):</strong><img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0dba417146.png\" alt=\"pj.png\"></p>\n<h2>4.Deloy</h2>\n<p>Ban đầu c&aacute;c bạn v&agrave;o Azure portal v&agrave; chọn&nbsp;<strong>Create a resource</strong>.<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0d85fe99a8.png\" alt=\"1.png\">Sau đ&oacute; chọn mục&nbsp;<strong>Web App</strong>&nbsp;v&agrave;&nbsp;<strong>create</strong></p>\n<p><img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0d8d145298.png\" alt=\"2.png\">L&uacute;c n&agrave;y giao diện&nbsp;<strong>Create Web App</strong>&nbsp;sẽ hiện ra như h&igrave;nh:</p>\n<ul>\n<li>Mục số 1 : T&ecirc;n nh&oacute;m của project.</li>\n<li>Mục số 2: T&ecirc;n của web app m&igrave;nh đặt tuỳ &yacute;.</li>\n<li>Mục số 3: Ng&ocirc;n ngữ lập tr&igrave;nh ở đ&acirc;y m&igrave;nh chọn Java 8.</li>\n<li>Mục số 4:Chọn n&ecirc;n tảng ở deloy ở đ&acirc;y l&agrave; spring boot m&igrave;nh build ra file jar n&ecirc;n chọn Java SE (Embedded Web Server).</li>\n<li>Mục số 5: Ở đ&acirc;y sẽ chọn vị tr&iacute; đặt host.</li>\n<li>Mục Pricing plans: C&aacute;c bạn chọn Free F1.&nbsp;<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0d90c6e370.png\" alt=\"3.png\">&nbsp;Xong xu&ocirc;i rồi th&igrave; ấn&nbsp;<strong>Review + create</strong>&nbsp;<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0da9e94678.png\" alt=\"image.png\">&nbsp;Kiểm tra lại kỹ c&aacute;c th&ocirc;ng tin sau đ&oacute; ấn&nbsp;<strong>Create</strong>&nbsp;Đ&acirc;y l&agrave; khi tạo th&agrave;nh c&ocirc;ng.&nbsp;<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0dcb7ac6a0.png\" alt=\"image.png\">&nbsp;V&agrave;o&nbsp;<strong>Go to resource</strong>&nbsp;để v&agrave;o giao điện quản l&yacute;.&nbsp;<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0dd517c780.png\" alt=\"image.png\">&nbsp;Tiếp theo c&aacute;c bạn v&agrave;o&nbsp;<strong>Deployment Center</strong>.&nbsp;<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0ddbbbae08.png\" alt=\"image.png\">&nbsp;Phần source c&aacute;c bạn chọn Github sau đ&oacute; hệ thống sẽ y&ecirc;u cầu cấp quyền cho Azure sau khi cấp quyền xong th&igrave; được như h&igrave;nh. Ở phần GitHub th&igrave; c&aacute;c bạn chọn c&aacute;c th&ocirc;ng tin tương ứng với project như&nbsp;<strong>Organization, Repository, Branch</strong>.&nbsp;<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0de155c635.png\" alt=\"image.png\">&nbsp;Điền đầy đủ c&aacute;c th&ocirc;ng tin c&aacute;c bạn chọn save &agrave; đợi trong v&agrave;i ph&uacute;t để hệ th&ocirc;ng set up nếu ok sẽ như h&igrave;nh.&nbsp;<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0defb63303.png\" alt=\"image.png\">&nbsp;V&agrave;o mục log để xem trạng th&aacute;i deloy app v&agrave;o&nbsp;<strong>Build/Deploy Logs</strong>&nbsp;để xem trạng th&aacute;i.&nbsp;<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0df625189b.png\" alt=\"image.png\">&nbsp;Kết quả như h&igrave;nh th&igrave; l&agrave; deloy th&agrave;nh c&ocirc;ng rồi !!&nbsp;<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0dfac58304.png\" alt=\"image.png\">&nbsp;B&acirc;y giờ test thử xem v&agrave;o link&nbsp;<a href=\"https://fullstack.edu.vn/external-url?continue=https%3A%2F%2Fmycontactapi.azurewebsites.net%2Fswagger-ui.html\" target=\"_blank\" rel=\"noopener noreferrer\">https://mycontactapi.azurewebsites.net/swagger-ui.html</a>&nbsp;<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0e052d2c9c.png\" alt=\"image.png\">&nbsp;V&agrave; n&oacute; đ&atilde; l&ecirc;n. B&acirc;y giờ test thử 1 method GET xem thế n&agrave;o.&nbsp;<img src=\"https://files.fullstack.edu.vn/f8-prod/blog_posts/6529/63f0e08ecf922.png\" alt=\"image.png\"> Như vậy l&agrave; ch&uacute;ng ta đ&atilde; thực hiện được c&aacute;c bước để deploy app l&ecirc;n Azure Web Apps . Ch&uacute;c c&aacute;c bạn th&agrave;nh c&ocirc;ng ! C&oacute; bất k&igrave; c&acirc;u hỏi hoặc c&acirc;u thảo luận n&agrave;o c&aacute;c bạn h&atilde;y comment b&ecirc;n dưới nh&eacute; !</li>\n</ul>\n</div>\n<div class=\"BlogDetail_bodyBottom__BuJE1\">\n<div class=\"BlogDetail_tags__e0PwM\">&nbsp;</div>\n</div>", webViewHeight: .constant(.zero))
}
