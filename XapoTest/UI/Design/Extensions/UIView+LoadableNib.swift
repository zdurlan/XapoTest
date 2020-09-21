//
//  UIView+LoadableNib.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib<T: UIView>(owner: Any? = nil) -> T {
        let nibName = String(describing: self)
        let nib = UINib(nibName: nibName, bundle: nil)
        guard let nibview = nib.instantiate(withOwner: owner, options: nil).first as? T else {
            assertionFailure("View \(nibName) not available")
            return T()
        }
        return nibview
    }
}
