//
//  TrendingProjectModel.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import Foundation

struct TrendingProject: Decodable {
    let author: String
    let name: String
    let avatar: String
    let url: String
    let language: String
    let languageColor: String
    let stars: Int
    let forks: Int
    let description: String
    let builtBy: [GithubUser]
}

struct GithubUser: Decodable, Equatable {
    let userLink: String
    let avatar: String
    let username: String

    private enum CodingKeys: String, CodingKey {
        case userLink = "href", avatar, username
    }

    static func == (lhs: GithubUser, rhs: GithubUser) -> Bool {
        return lhs.userLink == rhs.userLink
    }
}
