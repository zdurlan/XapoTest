//
//  UIApplication+StatusBar.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero

        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }

}
