//
//  UIDevice+Extensions.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 19/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.windows.first { $0.isKeyWindow }?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        } else {
            return false
        }
    }
}
