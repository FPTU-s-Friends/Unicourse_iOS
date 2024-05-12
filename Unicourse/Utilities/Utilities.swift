//  Utilities.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 6/5/24.
//

import Foundation
import UIKit

final class Utilities {
    static let shared = Utilities()

    @MainActor
    func visibleTopViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first(where: { $0.isKeyWindow })
            .flatMap { $0.rootViewController }

        return controller.flatMap { [$0 as? UINavigationController, $0 as? UITabBarController, $0.presentedViewController].compactMap { $0 }.first.flatMap { visibleTopViewController(controller: $0) } ?? $0 }
    }
}
