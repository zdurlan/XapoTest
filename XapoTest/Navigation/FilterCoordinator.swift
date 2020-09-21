//
//  FilterCoordinator.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

protocol FilterCoordinatorNavigationProtocol: class {
    func applyFilters(_ filters: ProjectFilters)
}

class FilterCoordinator: NavigationCoordinator {
    private var projectFilters: ProjectFilters!
    weak var navigationDelegate: FilterCoordinatorNavigationProtocol?

    convenience init(navigationController: UINavigationController, projectFilters: ProjectFilters) {
        self.init(navigationController: navigationController)
        self.projectFilters = projectFilters
    }

    override func start() {
        let filterViewController: FiltersViewController = Storyboard.projects.loadViewController()
        let filtersViewModel = FiltersViewModel(filters: projectFilters)
        filtersViewModel.navigationDelegate = self
        filterViewController.viewModel = filtersViewModel

        start(with: filterViewController)
    }
}

extension FilterCoordinator: FiltersViewModelNavigationProtocol {
    func applyFilters(_ filters: ProjectFilters) {
        navigationDelegate?.applyFilters(filters)
    }

    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
