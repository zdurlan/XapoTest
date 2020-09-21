//
//  UIViewController+Alert.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlertController(title: String, message: String) {
        DispatchQueue.main.async {
            let otherAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            otherAlert.addAction(dismiss)
            self.present(otherAlert, animated: true, completion: nil)
        }
    }
}
