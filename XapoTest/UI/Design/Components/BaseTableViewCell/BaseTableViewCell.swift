//
//  BaseTableViewCell.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    private var separatorView: UIView?

    func hideSeparator(separatorHidden: Bool = true) {
        guard separatorView != nil else {
            return
        }
        separatorView!.isHidden = separatorHidden
    }

    func addSeparatorView(insets: UIEdgeInsets? = nil) {
        if separatorView != nil {
            return
        }

        separatorView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 1))
        separatorView!.backgroundColor = UIColor.Xapo.xapoBlue.withAlphaComponent(0.2)
        separatorView!.pinBottom(to: self, insets: insets ?? UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: -16))
        separatorView!.setHeightConstraint(heightConstant: 1)
    }
}
