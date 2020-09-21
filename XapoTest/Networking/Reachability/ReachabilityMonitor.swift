//
//  ReachabilityMonitor.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 18/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import SystemConfiguration
import UIKit

typealias ChangedNetworkStateCallback = (Bool) -> Void

class ReachabilityMonitor {
    static var changedNetworkStateCallBack: ChangedNetworkStateCallback?
    static var isNetworkReachable: Bool = false

    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    private let callbackQueue = DispatchQueue.global(qos: .background)

    private var lastStateWasReachable = true
    private var isListening = false

    private var notificationView: ReachabilityNotificationView?
    private let window: UIWindow!

    init(window: UIWindow) {
        self.window = window
    }

    var hasInternetConnection = true

    func startMonitoring() {
        guard !isListening, let reachability = reachability else {
            return
        }

        var context = SCNetworkReachabilityContext(version: 0, info: nil,
                                                   retain: nil, release: nil,
                                                   copyDescription: nil)
        context.info = UnsafeMutableRawPointer(Unmanaged<ReachabilityMonitor>.passUnretained(self).toOpaque())

        let callbackClosure: SCNetworkReachabilityCallBack = { (reachability, flags, info) in
            guard let info = info else {
                return
            }

            let monitor = Unmanaged<ReachabilityMonitor>.fromOpaque(info).takeUnretainedValue()
            monitor.checkReachability(with: flags)
        }

        if !SCNetworkReachabilitySetCallback(reachability, callbackClosure, &context) {
            startMonitoring()
            return
        }

        if !SCNetworkReachabilitySetDispatchQueue(reachability, callbackQueue) {
            startMonitoring()
            return
        }

        callbackQueue.async {
            var flags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)
            self.checkReachability(with: flags)
        }

        isListening = true
    }

    func stop() {
        guard isListening, let reachability = reachability else {
            return
        }

        SCNetworkReachabilitySetCallback(reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability, nil)

        isListening = false
    }

    private func checkReachability(with flags: SCNetworkReachabilityFlags) {
        let isReachable = newStatus(from: flags)
        hasInternetConnection = isReachable
        ReachabilityMonitor.isNetworkReachable = isReachable

        if isReachable != lastStateWasReachable {
            lastStateWasReachable = isReachable
            networkStateChanged(isNetworkReachable: isReachable)
        }
    }

    private func newStatus(from flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)

        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }

    private func networkStateChanged(isNetworkReachable: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }

            if isNetworkReachable {
                strongSelf.updateAndRemoveAlert()
            } else {
                strongSelf.showAlert()
            }
            ReachabilityMonitor.isNetworkReachable = isNetworkReachable
            ReachabilityMonitor.changedNetworkStateCallBack?(isNetworkReachable)
        }
    }

    private func showAlert() {
        guard notificationView == nil else {
            return
        }

        window.windowLevel = .statusBar

        notificationView = ReachabilityNotificationView.reachabilityNotificationView(isReachable: false)

        guard let notificationView = notificationView else {
            return
        }

        notificationView.alpha = 0

        notificationView.pinTop(to: window)

        let appWindows = UIApplication.shared.windows
        let statusBarManager = appWindows.first(where: { $0.isKeyWindow })?.windowScene?.statusBarManager
        guard let statusBar = statusBarManager?.statusBarFrame else {
            assertionFailure("Status bar should be visible")
            return
        }
        notificationView.setHeightConstraint(heightConstant: statusBar.height)

        UIView.animate(withDuration: AnimationConstants.globalAnimationsDuration) {
            notificationView.alpha = 1
        }
    }

    private func updateAndRemoveAlert() {
        if let notificationView = notificationView {
            notificationView.setLayout(isReachable: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                guard let strongSelf = self else {
                    return
                }

                strongSelf.removeAlert()
            }
        }
    }

    private func removeAlert() {
        UIView.animate(withDuration: AnimationConstants.globalAnimationsDuration, animations: { [weak self] in
            guard let strongSelf = self, let notificationView = strongSelf.notificationView else {
                return
            }

            notificationView.alpha = 0
        }, completion: { [weak self] _ in
            guard let strongSelf = self, let notificationView = strongSelf.notificationView else {
                return
            }

            notificationView.removeFromSuperview()
            strongSelf.notificationView = nil
            strongSelf.window.windowLevel = .normal
        })
    }
}

private struct Constants {
    static let sideSpace: CGFloat = 16
    static let bottomSpace: CGFloat = 93
}
