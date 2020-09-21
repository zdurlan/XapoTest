//
//  Coordinator.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 19/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

enum PresentationStyle {
    case push
    case modal
    case none
}

protocol CoordinatorProtocol: DeinitSubscriber, DeinitObservable {
    var childCoordinators: [String: CoordinatorProtocol] { get set }

    func identifier() -> String
    static func identifier() -> String

    func start()
    func start(_ coordinator: CoordinatorProtocol)

    func retain(_ coordinator: CoordinatorProtocol)
    func release(_ coordinator: CoordinatorProtocol)
}

extension CoordinatorProtocol {
    func identifier() -> String {
        return String(describing: type(of: self))
    }

    static func identifier() -> String {
        return String(describing: self)
    }

    func retain(_ coordinator: CoordinatorProtocol) {
        childCoordinators[coordinator.identifier()] = coordinator
    }

    func release(_ coordinator: CoordinatorProtocol) {
        childCoordinators[coordinator.identifier()] = nil
    }

    func releaseAllCoordinators() {
        childCoordinators.removeAll()
    }

    func didDeinit(_ observable: DeinitObservable) {
        switch observable {
        case let deinitedCoordinator as CoordinatorProtocol:
            release(deinitedCoordinator)
        default:
            deinitSubscriber?.didDeinit(self)
        }
    }
}

protocol DeinitObservable: class {
    var deinitSubscriber: DeinitSubscriber? { get set }
}

protocol DeinitSubscriber: class {
    func didDeinit(_ observable: DeinitObservable)
}

class Coordinator: NSObject, CoordinatorProtocol {
    var transitioningAnimator: TransitioningAnimator?
    var childCoordinators: [String: CoordinatorProtocol] = [:]
    weak var deinitSubscriber: DeinitSubscriber?

    func start() {
        assertionFailure("This method should be implemented by subclasses")
    }

    func start(_ coordinator: CoordinatorProtocol) {
        coordinator.deinitSubscriber = self
        retain(coordinator)
        coordinator.start()
    }
}

extension Coordinator: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitioningAnimator?.isDisplaying = true
        return transitioningAnimator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitioningAnimator?.isDisplaying = false
        return transitioningAnimator
    }
}

class NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(with viewController: UIViewController, presentation: PresentationStyle = .push) {
        if let deinitObservableController = viewController as? DeinitObservable {
            deinitObservableController.deinitSubscriber = self
        } else {
            let identifier = String(describing: type(of: viewController))
            assertionFailure("[\(identifier)] Coordinate view controllers must be DeinitObservable")
        }

        switch presentation {
        case .push:
            navigationController.pushViewController(viewController, animated: true)
        case .modal:
            navigationController.present(viewController, animated: true, completion: nil)
        case .none:
            break
        }
    }
}
