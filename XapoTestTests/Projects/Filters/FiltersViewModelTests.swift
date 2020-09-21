//
//  FiltersViewModelTests.swift
//  XapoTestTests
//
//  Created by Alin Zdurlan on 21/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import XCTest
@testable import XapoTest

class FiltersViewModelTests: XCTestCase {
    class MockNavigationDelegate: FiltersViewModelNavigationProtocol {
        func dismiss() {
            didDismiss = true
        }

        func applyFilters(_ filters: ProjectFilters) {
            didApplyFilters = true
        }

        var didDismiss = false
        var didApplyFilters = false
    }

    private var viewModel: FiltersViewModel!

    override func setUp() {
        super.setUp()
        viewModel = FiltersViewModel(filters: ProjectFilters(timePeriod: .daily, language: .all))
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testTitle() {
        XCTAssertEqual(viewModel.title, "Filters")
    }

    func testDismiss() {
        let navigationDelegate = MockNavigationDelegate()
        viewModel.navigationDelegate = navigationDelegate

        viewModel.dismiss()
        XCTAssertTrue((viewModel.navigationDelegate as? MockNavigationDelegate)?.didDismiss ?? false)
    }

    func testApplyFilters() {
        let navigationDelegate = MockNavigationDelegate()
        viewModel.navigationDelegate = navigationDelegate

        viewModel.applyFilters()
        XCTAssertTrue((viewModel.navigationDelegate as? MockNavigationDelegate)?.didApplyFilters ?? false)
    }

    func testChangedPeriod() {
        viewModel.changedPeriod(0)

        XCTAssertEqual(viewModel.filters.timePeriod, TimePeriod.daily)

        viewModel.changedPeriod(1)

        XCTAssertEqual(viewModel.filters.timePeriod, TimePeriod.weekly)

        viewModel.changedPeriod(2)

        XCTAssertEqual(viewModel.filters.timePeriod, TimePeriod.monthly)
    }

    func testChangedLanguage() {
        viewModel.changedLanguage(0)

        XCTAssertEqual(viewModel.filters.language, ProgrammingLanguage.all)

        viewModel.changedLanguage(1)

        XCTAssertEqual(viewModel.filters.language, ProgrammingLanguage.swift)
    }
}
