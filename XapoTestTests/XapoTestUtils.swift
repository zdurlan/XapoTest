//
//  XapoTestUtils.swift
//  XapoTestTests
//
//  Created by Alin Zdurlan on 21/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

@testable import XapoTest

class XapoTestUtils {
    static func mockProjectsDatasource() -> [TrendingProjectsCellModel] {
        let project = mockProject()
        return [TrendingProjectsCellModel(project: project)]
    }

    static func mockProject() -> TrendingProject {
        let user = GithubUser(userLink: "a", avatar: "a", username: "a")
        let project = TrendingProject(author: "a", name: "a", avatar: "A", url: "a", language: "a",
        languageColor: "a", stars: 9, forks: 10, description: "a",
        builtBy: [user])

        return project
    }
}
