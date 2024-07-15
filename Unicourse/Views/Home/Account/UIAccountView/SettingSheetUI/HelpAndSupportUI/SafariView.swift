//
//  SafariView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 21/6/24.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    var onDismiss: (() -> Void)?

    class Coordinator: NSObject, SFSafariViewControllerDelegate, UIAdaptivePresentationControllerDelegate {
        var parent: SafariView

        init(parent: SafariView) {
            self.parent = parent
        }

        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            parent.onDismiss?()
        }

        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.onDismiss?()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = context.coordinator
        safariVC.presentationController?.delegate = context.coordinator
        safariVC.modalPresentationStyle = .fullScreen
        return safariVC
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

struct WebViewUI: View {
    let url: String

    var body: some View {
        if let url = URL(string: url) {
            SafariView(url: url)
                .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
        } else {
            Text("Invalid URL")
        }
    }
}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "https://unicourse.vn")!)
    }
}
