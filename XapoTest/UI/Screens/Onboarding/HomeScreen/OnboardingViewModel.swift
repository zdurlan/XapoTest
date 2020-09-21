//
//  OnboardingViewModel.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 18/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

private struct Constants {
    static let privacyURL = "https://static.xapo.com/terms/privacy-policy.html"
    static let termsURL = "https://static.xapo.com/terms/index.html"
    static let xapoURL = "https://www.xapo.com"
}

protocol OnboardingNavigationProtocol: class {
    func onboardingViewModelEnterApp()
}

class OnboardingViewModel {
    weak var navigationDelegate: OnboardingNavigationProtocol?

    var dummyText: String {
        return """
        iOS Test for Xapo bank \n
        Lorem Ipsum is simply dummy text of the printing and typesetting industry.
        Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
        """
    }

    var welcomeText: String {
        return "Welcome to iOS \n Test"
    }

    var privacyURL: String {
        return Constants.privacyURL
    }

    var termsURL: String {
        return Constants.termsURL
    }

    func setupAttributedStringPrivacyAndTerms() -> NSMutableAttributedString {
        let string = "Privacy Policy and Terms of use"
        let attributedString = NSMutableAttributedString(string: string)

        var foundRange = attributedString.mutableString.range(of: "Privacy Policy")
        attributedString.addAttribute(NSAttributedString.Key.link, value: privacyURL, range: foundRange)
        foundRange = attributedString.mutableString.range(of: "Terms of use")
        attributedString.addAttribute(NSAttributedString.Key.link, value: termsURL, range: foundRange)
        foundRange = attributedString.mutableString.range(of: "and")

        let fontAndColorAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 13)
        ]
        let range = attributedString.mutableString.range(of: attributedString.mutableString as String)
        attributedString.addAttributes(fontAndColorAttributes,
                                       range: range)
        return attributedString
    }

    func didTapGoToXapo(application: URLOpenerProtocol = UIApplication.shared, completion: ((Bool) -> Void)? = nil) {
        let urlOpener = URLOpener(application: application)
        guard let url = URL(string: Constants.xapoURL) else {
            assertionFailure("Incorrect URL")
            return
        }
        urlOpener.openWebsite(url: url, completion: completion)
    }

    func didTapEnterApp() {
        navigationDelegate?.onboardingViewModelEnterApp()
    }
}
