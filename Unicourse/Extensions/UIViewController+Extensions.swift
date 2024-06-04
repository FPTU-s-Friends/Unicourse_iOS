//
//  UIViewController+Extensions.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 3/6/24.
//

import UIKit

extension UIViewController {
    func setupKeyboardLayout() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(notification: Notification) {
        let responderKeyboardType = UIResponder.keyboardFrameEndUserInfoKey
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[responderKeyboardType] as? NSValue else { return }
        
        let keyboardIsHidden = view.frame.origin.y == 0
        
        if keyboardIsHidden {
            view.frame.origin.y -= keyboardFrame.cgRectValue.height
        }
    }
    
    @objc
    private func keyboardWillHide(notification: Notification) {
        let keyboardIsHidden = view.frame.origin.y == 0
        
        if !keyboardIsHidden {
            view.frame.origin.y = 0
        }
    }
}
