//
//  OnboardingCoordinator.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class TrendingProjectsCoordinator: NavigationCoordinator {
    private var viewModel: TrendingProjectsViewModel!

    override func start() {
        let trendingProjectsVC: TrendingProjectsViewController = Storyboard.projects.loadViewController()
        viewModel = TrendingProjectsViewModel()
        viewModel.navigationDelegate = self
        trendingProjectsVC.viewModel = viewModel

        navigationController.setStatusBar(backgroundColor: UIColor.Xapo.xapoBlue)
        start(with: trendingProjectsVC)
    }

    private func setupFilters(_ filters: ProjectFilters) {
        viewModel.filters = filters
    }
}

extension TrendingProjectsCoordinator: TrendingProjectsNavigationProtocol {
    func showDetails(for project: TrendingProject) {
        let detailsCoordinator = ProjectDetailsCoordinator(navigationController: navigationController, project: project)
        start(detailsCoordinator)
    }

    func showFilters(viewModel: TrendingProjectsViewModel) {
        let filtersCoordinator = FilterCoordinator(navigationController: navigationController,
                                                   projectFilters: viewModel.filters ?? ProjectFilters())
        filtersCoordinator.navigationDelegate = self
        start(filtersCoordinator)
    }

    func dismissTrendingProjects() {
        navigationController.popViewController(animated: true)
    }
}

extension TrendingProjectsCoordinator: FilterCoordinatorNavigationProtocol {
    func applyFilters(_ filters: ProjectFilters) {
        setupFilters(filters)
        navigationController.popViewController(animated: true)
    }
}
