//
//  URLOpener.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 21/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

protocol URLOpenerProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any],
              completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: URLOpenerProtocol { }

struct URLOpener {
    private let application: URLOpenerProtocol

    init(application: URLOpenerProtocol) {
        self.application = application
    }

    func openWebsite(url: URL, completion: ((Bool) -> Void)? = nil) {
        if application.canOpenURL(url) {
            application.open(url, options: [:], completionHandler: completion)
        } else {
            completion?(false)
        }
    }
}
