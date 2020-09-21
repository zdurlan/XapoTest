//
//  FiltersViewModel.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import Foundation

protocol FiltersViewModelNavigationProtocol: class {
    func dismiss()
    func applyFilters(_ filters: ProjectFilters)
}

class FiltersViewModel {
    // MARK: - Properties
    var title: String {
        return "Filters"
    }

    var filters: ProjectFilters

    weak var navigationDelegate: FiltersViewModelNavigationProtocol?

    // MARK: - Init
    init(filters: ProjectFilters) {
        self.filters = filters
    }

    // MARK: - Methods
    func applyFilters() {
        navigationDelegate?.applyFilters(filters)
    }

    func dismiss() {
        navigationDelegate?.dismiss()
    }

    func changedPeriod(_ selectedIndex: Int) {
        var timePeriod: TimePeriod = .daily
        switch selectedIndex {
        case 0:
            timePeriod = .daily
        case 1:
            timePeriod = .weekly
        case 2:
            timePeriod = .monthly
        default:
            break
        }
        filters.timePeriod = timePeriod
    }

    func changedLanguage(_ selectedIndex: Int) {
        var language: ProgrammingLanguage = .all
        switch selectedIndex {
        case 0:
            language = .all
        case 1:
            language = .swift
        default:
            break
        }
        filters.language = language
    }
}
