//
//  OnboardingViewModelTests.swift
//  XapoTestTests
//
//  Created by Alin Zdurlan on 18/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import XCTest
@testable import XapoTest

private struct MockUIApplication: URLOpenerProtocol {
    var canOpen: Bool

    func canOpenURL(_ url: URL) -> Bool {
        return canOpen
    }

    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any],
              completionHandler completion: ((Bool) -> Void)?) {
        if canOpen {
            completion?(true)
        }
    }
}

class OnboardingViewModelTests: XCTestCase {
    class MockNavigationDelegate: OnboardingNavigationProtocol {
        func onboardingViewModelEnterApp() {
            didEnterApp = true
        }

        var didEnterApp = false
    }

    private var viewModel: OnboardingViewModel!

    override func setUp() {
        super.setUp()
        viewModel = OnboardingViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testDummyText() {
        let dummyText = """
        iOS Test for Xapo bank \n
        Lorem Ipsum is simply dummy text of the printing and typesetting industry.
        Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
        """
        XCTAssertEqual(viewModel.dummyText, dummyText)
    }

    func testWelcomeText() {
        XCTAssertEqual(viewModel.welcomeText, "Welcome to iOS \n Test")
    }

    func testPrivacyURL() {
        XCTAssertEqual(viewModel.privacyURL, "https://static.xapo.com/terms/privacy-policy.html")
    }

    func testTermsURL() {
        XCTAssertEqual(viewModel.termsURL, "https://static.xapo.com/terms/index.html")
    }

    func testGoToXapo() {
        let mockUIApplication = MockUIApplication(canOpen: true)
        let waitForWebsiteOpen = expectation(description: "Xapo website not opened!")

        viewModel.didTapGoToXapo(application: mockUIApplication) { open in
            waitForWebsiteOpen.fulfill()
            XCTAssertTrue(open)
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testEnterApp() {
        let navigationDelegate = MockNavigationDelegate()
        viewModel.navigationDelegate = navigationDelegate

        viewModel.didTapEnterApp()
        XCTAssertTrue((viewModel.navigationDelegate as? MockNavigationDelegate)?.didEnterApp ?? false)
    }
}
