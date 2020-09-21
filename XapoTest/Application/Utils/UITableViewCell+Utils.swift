//
//  UITableViewCell+Utils.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }

    static func register(to tableView: UITableView) {
        let nibFile = UINib(nibName: identifier, bundle: nil)
        tableView.register(nibFile, forCellReuseIdentifier: identifier)
    }
}
