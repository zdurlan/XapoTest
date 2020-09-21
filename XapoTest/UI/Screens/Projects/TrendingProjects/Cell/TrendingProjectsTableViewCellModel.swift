//
//  TrendingProjectsTableViewCellModel.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import Foundation

class TrendingProjectsCellModel {
    // MARK: - Properties
    private let trendingProject: TrendingProject

    var name: String {
        return trendingProject.name
    }

    var color: String {
        return trendingProject.languageColor
    }

    var language: String {
        return trendingProject.language
    }

    var stars: Int {
        return trendingProject.stars
    }

    var forks: Int {
        return trendingProject.forks
    }

    // MARK: - Init
    init(project: TrendingProject) {
        self.trendingProject = project
    }

    // MARK: - Methods
    func getRawModel() -> TrendingProject {
        return trendingProject
    }
}
