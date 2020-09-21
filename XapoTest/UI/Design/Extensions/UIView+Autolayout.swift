//
//  UIView+Autolayout.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 19/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

extension UIView {
    func pin(to superview: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)

        let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top)
        let leading = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left)
        let trailing = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right)
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom)

        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }

    func pinTop(to superview: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)

        let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top)
        let leading = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left)
        let trailing = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right)

        NSLayoutConstraint.activate([top, leading, trailing])
    }

    func pinBottom(to superview: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)

        let leading = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left)
        let trailing = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right)
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom)

        NSLayoutConstraint.activate([leading, trailing, bottom])
    }

    func setWidthConstraint(widthConstant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: NSLayoutConstraint = widthAnchor.constraint(equalToConstant: widthConstant)
        constraint.isActive = true
        constraint.priority = UILayoutPriority.defaultHigh
    }

    func setHeightConstraint(heightConstant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
    }
}
