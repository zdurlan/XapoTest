//
//  TrendingProjectDetailsViewModelTests.swift
//  XapoTestTests
//
//  Created by Alin Zdurlan on 21/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import XCTest
@testable import XapoTest

class ProjectDetailsViewModelTests: XCTestCase {
    class MockNavigationDelegate: ProjectDetailsViewModelNavigationProtocol {
        func dismiss() {
            didDismiss = true
        }

        var didDismiss = false
    }

    private var viewModel: ProjectsDetailsViewModel!
    private var project: TrendingProject!

    override func setUp() {
        super.setUp()
        project = XapoTestUtils.mockProject()
        viewModel = ProjectsDetailsViewModel(project: project)
    }

    override func tearDown() {
        viewModel = nil
        project = nil
        super.tearDown()
    }

    func testTitle() {
        XCTAssertEqual(viewModel.title, project.name)
    }

    func testColor() {
        XCTAssertEqual(viewModel.color, project.languageColor)
    }

    func testLanguage() {
        XCTAssertEqual(viewModel.language, project.language)
    }

    func testStars() {
        XCTAssertEqual(viewModel.stars, project.stars)
    }

    func testForks() {
        XCTAssertEqual(viewModel.forks, project.forks)
    }

    func testURL() {
        XCTAssertEqual(viewModel.url, project.url)
    }

    func testAvatarURL() {
        XCTAssertEqual(viewModel.avatarUrl, project.avatar)
    }

    func testDescription() {
        XCTAssertEqual(viewModel.description, project.description)
    }

    func testAuthor() {
        XCTAssertEqual(viewModel.author, project.author)
    }

    func testBuiltBy() {
        XCTAssertEqual(viewModel.builtBy, project.builtBy)
    }

    func testSetupAttributedStringURL() {
        XCTAssertEqual(viewModel.setupAttributedStringURL().string, project.url)
    }

    func testDismiss() {
        let navigationDelegate = MockNavigationDelegate()
        viewModel.navigationDelegate = navigationDelegate

        viewModel.dismiss()
        XCTAssertTrue((viewModel.navigationDelegate as? MockNavigationDelegate)?.didDismiss ?? false)
    }

    func testNumberOfItems() {
        XCTAssertEqual(viewModel.numberOfItems(), project.builtBy.count)
    }

    func testCell() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        ProjectDetailsContributorsCell.register(to: collectionView)
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertTrue(viewModel.cell(for: collectionView, at: indexPath) is ProjectDetailsContributorsCell)
    }
}
