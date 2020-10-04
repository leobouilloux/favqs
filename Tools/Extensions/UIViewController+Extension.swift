//
//  UIViewController+Extension.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

extension UIViewController {
    func setStatusBarStyle(with style: UIStatusBarStyle, animated: Bool) {
        UIApplication.shared.setStatusBarStyle(style, animated: animated)
    }

    func setStatusBarStyle(with style: UIStatusBarStyle) {
        UIApplication.shared.statusBarStyle = style
    }

    func setStatusBarVisibility(isHidden: Bool, animation: UIStatusBarAnimation) {
        UIApplication.shared.setStatusBarHidden(isHidden, with: animation)
    }

    func setStatusBarVisibility(isHidden: Bool) {
        UIApplication.shared.isStatusBarHidden = isHidden
    }

    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
