//
//  StoryboardCoordinator.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 19/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case onboarding = "Onboarding"
    case projects = "Projects"
}

extension Storyboard {

    var rootViewController: UIViewController? {
        return current.instantiateInitialViewController()
    }

    var initialViewController: UIViewController? {
        return current.instantiateInitialViewController()
    }

    func loadViewController<T: UIViewController>() -> T {
        if let loadedVC = current.instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
            return loadedVC
        }
        fatalError("View Controller does not have the same Storyboard identifier as its class name")
    }
}

fileprivate extension Storyboard {

    private var current: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: nil)
    }
}
