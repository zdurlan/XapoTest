//
//  ProjectsService.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 19/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import Foundation

enum ProgrammingLanguage: String {
    case all = ""
    case swift
}

enum TimePeriod: String {
    case daily
    case weekly
    case monthly
}

class ProjectsServiceFactory {

    static func makeTrendingProjectsRequest(language: ProgrammingLanguage = .all,
                                            timePeriod: TimePeriod = .daily) -> APIRequest {
        let deviceListRequest = APIRequest(method: .get, path: ApiConstants.Projects.TrendingPath)
        deviceListRequest.queryItems = [
            URLQueryItem(name: "language", value: language.rawValue),
            URLQueryItem(name: "since", value: timePeriod.rawValue)
        ]
        return deviceListRequest
    }
}
