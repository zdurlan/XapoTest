//
//  BaseLightStatusBarViewController.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

public protocol ActivityIndicatorPresenter {
    /// The activity indicator
    var activityIndicator: UIActivityIndicatorView { get }

    /// Show the activity indicator in the view
    func showActivityIndicator(withBackgroundAlpha: CGFloat)

    /// Hide the activity indicator in the view
    func hideActivityIndicator()
}

class BaseLightStatusBarVC: UIViewController, ActivityIndicatorPresenter, DeinitObservable {
    var activityIndicator = UIActivityIndicatorView()
    var onDeinit: (() -> Void)?
    weak var deinitSubscriber: DeinitSubscriber?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    deinit {
        deinitSubscriber?.didDeinit(self)
    }
}

public extension ActivityIndicatorPresenter where Self: UIViewController {

    func showActivityIndicator(withBackgroundAlpha: CGFloat = 1) {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            self.activityIndicator.style = .large
            self.activityIndicator.color = UIColor.Xapo.xapoBlue
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
            self.view.alpha = withBackgroundAlpha
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.view.alpha = 1
            self.view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}
