//
//  TrendingProjectsCellModelTests.swift
//  XapoTestTests
//
//  Created by Alin Zdurlan on 21/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import XCTest
@testable import XapoTest

class TrendingProjectsCellModelTests: XCTestCase {
    private var viewModel: TrendingProjectsCellModel!
    private var project: TrendingProject!

    override func setUp() {
        super.setUp()
        project = XapoTestUtils.mockProject()
        viewModel = TrendingProjectsCellModel(project: project)
    }

    override func tearDown() {
        viewModel = nil
        project = nil
        super.tearDown()
    }

    func testName() {
        XCTAssertEqual(viewModel.name, project.name)
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
}
