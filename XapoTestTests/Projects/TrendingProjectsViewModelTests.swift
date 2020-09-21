//
//  TrendingProjectsViewModelTests.swift
//  XapoTestTests
//
//  Created by Alin Zdurlan on 21/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import XCTest
@testable import XapoTest

private class MockURLSession: NetworkSession {
    var data: Data?
    var error: Error?

    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}

class TrendingProjectsViewModelTests: XCTestCase {
    class MockNavigationDelegate: TrendingProjectsNavigationProtocol {
        func dismissTrendingProjects() {
            didDismiss = true
        }

        func showFilters(viewModel: TrendingProjectsViewModel) {
            shownFilters = true
        }

        func showDetails(for project: TrendingProject) {
            shownDetails = true
        }

        var didDismiss = false
        var shownFilters = false
        var shownDetails = false
    }

    class MockDelegate: TrendingProjectsViewModelProtocol {
        func showActivityIndicator(shouldShow: Bool) {
            didShowActivityIndicator = true
        }

        func showAlert(title: String, message: String) {
            didShowAlert = true
        }

        func didSetDatasource() {
            setDatasource = true
        }

        var didShowAlert = false
        var setDatasource = false
        var didShowActivityIndicator = false
    }

    private var viewModel: TrendingProjectsViewModel!

    override func setUp() {
        super.setUp()
        let mockSession = MockURLSession()
        viewModel = TrendingProjectsViewModel(apiClient: APIClient(session: mockSession))
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testTitle() {
        XCTAssertEqual(viewModel.title, "Trending Projects")
    }

    func testLoadDatasource() {
        let waitForLoadingData = expectation(description: "Data not loaded")

        let modelDelegate = MockDelegate()
        viewModel.delegate = modelDelegate
        viewModel.loadDataSource { [weak self] in
            waitForLoadingData.fulfill()

            XCTAssertTrue((self?.viewModel.delegate as? MockDelegate)?.setDatasource ?? false)
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testNumberOfRows() {
        XCTAssertEqual(viewModel.numberOfRows(), 20)

        viewModel = TrendingProjectsViewModel(datasource: XapoTestUtils.mockProjectsDatasource())
        XCTAssertEqual(viewModel.numberOfRows(), 1)
    }

    func testCell() {
        let tableView = UITableView()
        TrendingProjectsTableViewCell.register(to: tableView)
        let indexPath = IndexPath(row: 0, section: 0)

        viewModel = TrendingProjectsViewModel(datasource: XapoTestUtils.mockProjectsDatasource())
        XCTAssertTrue(viewModel.cell(for: tableView, at: indexPath) is TrendingProjectsTableViewCell)
    }

    func testDismiss() {
        let navigationDelegate = MockNavigationDelegate()
        viewModel.navigationDelegate = navigationDelegate

        viewModel.dismiss()
        XCTAssertTrue((viewModel.navigationDelegate as? MockNavigationDelegate)?.didDismiss ?? false)
    }

    func testShowFilters() {
        let navigationDelegate = MockNavigationDelegate()
        viewModel.navigationDelegate = navigationDelegate

        viewModel.showFilters()
        XCTAssertTrue((viewModel.navigationDelegate as? MockNavigationDelegate)?.shownFilters ?? false)
    }

    func testHasFilters() {
        XCTAssertFalse(viewModel.hasFilters())

        viewModel.filters = ProjectFilters(timePeriod: .weekly, language: .all)
        XCTAssertTrue(viewModel.hasFilters())
    }

    func testDidSelectRow() {
        viewModel = TrendingProjectsViewModel(datasource: XapoTestUtils.mockProjectsDatasource())

        let navigationDelegate = MockNavigationDelegate()
        viewModel.navigationDelegate = navigationDelegate

        viewModel.didSelectRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue((viewModel.navigationDelegate as? MockNavigationDelegate)?.shownDetails ?? false)
    }
}
