//
//  TrendingProjectDetailsCoordiniator.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class ProjectDetailsCoordinator: NavigationCoordinator {
    private var project: TrendingProject!

    convenience init(navigationController: UINavigationController, project: TrendingProject) {
        self.init(navigationController: navigationController)
        self.project = project
    }

    override func start() {
        let trendingProjectsDetailsVC: TrendingProjectDetailsVC = Storyboard.projects.loadViewController()
        let projectsDetailsViewModel = ProjectsDetailsViewModel(project: project)
        projectsDetailsViewModel.navigationDelegate = self
        trendingProjectsDetailsVC.viewModel = projectsDetailsViewModel

        start(with: trendingProjectsDetailsVC)
    }
}

extension ProjectDetailsCoordinator: ProjectDetailsViewModelNavigationProtocol {
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
