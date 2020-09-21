//
//  UIViewController+XapoNavigationBar.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

extension UIViewController {
    var xapoNavigationBar: XapoNavigationBar? {
        return self.view.subviews.filter({ $0.isKind(of: XapoNavigationBar.self) }).first as? XapoNavigationBar
    }

    func addXapoNavigationBar(title: String? = nil) {
        let navBar = XapoNavigationBar.navigationBar(with: title)
        self.view.addSubview(navBar)

        let appWindows = UIApplication.shared.windows
        let statusBarManager = appWindows.first(where: { $0.isKeyWindow })?.windowScene?.statusBarManager
        let height = statusBarManager?.statusBarFrame.height
        let statusBarInsets = UIEdgeInsets(top: height ?? 0, left: 0, bottom: 0, right: 0)
        navBar.pinTop(to: self.view, insets: statusBarInsets)

        self.navigationController?.isNavigationBarHidden = true
    }
}
