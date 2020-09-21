//
//  ReachabilityNotificationView.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 18/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class ReachabilityNotificationView: UIView {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var mainView: UIView!
    @IBOutlet private var topSafeLayoutConstraint: NSLayoutConstraint!

    static func reachabilityNotificationView(isReachable: Bool) -> ReachabilityNotificationView {
        let notificationView: ReachabilityNotificationView = ReachabilityNotificationView()
        notificationView.setLayout(isReachable: isReachable)

        if UIDevice.current.hasNotch {
            notificationView.topSafeLayoutConstraint.constant = -15
        } else {
            notificationView.topSafeLayoutConstraint.constant = -17
        }

        return notificationView
    }

    func setLayout(isReachable: Bool) {
        if isReachable {
            titleLabel.text = "Connected to the Internet"
            mainView.backgroundColor = UIColor.Xapo.green
        } else {
            titleLabel.text = "Disconnected from the Internet"
            mainView.backgroundColor = UIColor.black
        }
    }
}
