//
//  AppCoordinator.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 19/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    // MARK: - Properties
    private var reachabilityMonitor: ReachabilityMonitor?
    let window: UIWindow
    let rootViewController: UINavigationController

    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.setNavigationBarHidden(true, animated: false)
        super.init()

        let onboardingVC: OnboardingViewController = Storyboard.onboarding.loadViewController()
        let onboardingViewModel = OnboardingViewModel()
        onboardingViewModel.navigationDelegate = self
        onboardingVC.viewModel = onboardingViewModel
        rootViewController.pushViewController(onboardingVC, animated: false)
    }

    override func start() {
        startReachabilityMonitor()

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    func applicationMovesToBackground() {
        stopReachabilityMonitor()
    }

    func applicationMovesToForeground() {
        startReachabilityMonitor()
    }

    // MARK: - Private
    private func startReachabilityMonitor() {
        if reachabilityMonitor == nil {
            reachabilityMonitor = ReachabilityMonitor(window: window)
        }

        reachabilityMonitor!.startMonitoring()
    }

    private func stopReachabilityMonitor() {
        if let reachabilityMonitor = reachabilityMonitor {
            reachabilityMonitor.stop()
        }
    }

    private func enterApp() {
        let trendingProjectsCoordinator = TrendingProjectsCoordinator(navigationController: rootViewController)
        start(trendingProjectsCoordinator)
    }
}

extension AppCoordinator: OnboardingNavigationProtocol {
    func onboardingViewModelEnterApp() {
        enterApp()
    }
}
