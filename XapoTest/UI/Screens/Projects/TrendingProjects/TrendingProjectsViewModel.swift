//
//  TrendingProjectsViewModel.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

protocol TrendingProjectsNavigationProtocol: class {
    func dismissTrendingProjects()
    func showFilters(viewModel: TrendingProjectsViewModel)
    func showDetails(for project: TrendingProject)
}

protocol TrendingProjectsViewModelProtocol: class {
    func showAlert(title: String, message: String)
    func didSetDatasource()
    func showActivityIndicator(shouldShow: Bool)
}

class TrendingProjectsViewModel {
    // MARK: - Properties
    private var datasource: [TrendingProjectsCellModel] = []
    private let apiClient: APIClient

    weak var navigationDelegate: TrendingProjectsNavigationProtocol?
    weak var delegate: TrendingProjectsViewModelProtocol?

    var title: String {
        return "Trending Projects"
    }

    var filters: ProjectFilters? {
        didSet {
            applyFilters()
        }
    }

    // MARK: - Init
    init(datasource: [TrendingProjectsCellModel] = [], apiClient: APIClient = APIClient(session: URLSession.shared)) {
        self.datasource = datasource
        self.apiClient = apiClient
    }

    // MARK: - Table view methods
    func numberOfRows() -> Int {
        return datasource.isEmpty ? 20 : datasource.count
    }

    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cellID = TrendingProjectsTableViewCell.identifier

        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.selectionStyle = .none
        if let cell = cell as? TrendingProjectsTableViewCell, !datasource.isEmpty {
            cell.addSeparatorView()
            cell.viewModel = item(at: indexPath)
            if indexPath.row == datasource.count - 1 {
                cell.hideSeparator()
            }
        }

        datasource.isEmpty ? cell.showAnimatedGradientSkeleton() : cell.hideSkeleton()

        return cell
    }

    func didSelectRow(at index: IndexPath) {
        let cellModel = item(at: index)
        navigationDelegate?.showDetails(for: cellModel.getRawModel())
    }

    // MARK: - Methods
    func loadDataSource(completion: (() -> Void)? = nil) {
        getTrendingProjects(completion: completion)
    }

    func dismiss() {
        navigationDelegate?.dismissTrendingProjects()
    }

    func showFilters() {
        navigationDelegate?.showFilters(viewModel: self)
    }

    func applyFilters() {
        delegate?.showActivityIndicator(shouldShow: true)
        getTrendingProjects()
    }

    func hasFilters() -> Bool {
        return filters != nil
    }

    // MARK: - Private
    private func getTrendingProjects(completion: (() -> Void)? = nil) {
        var language: ProgrammingLanguage = .all
        var timePeriod: TimePeriod = .daily
        if let filters = filters {
            language = filters.language
            timePeriod = filters.timePeriod
        }
        let request = ProjectsServiceFactory.makeTrendingProjectsRequest(language: language, timePeriod: timePeriod)
        apiClient.perform(request) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            strongSelf.delegate?.showActivityIndicator(shouldShow: false)
            switch result {
            case .success(let response):
                guard let notificationsResponse = try? response.decode(to: [TrendingProject].self) else {
                    assertionFailure("Incorrect model from response")
                    return
                }
                strongSelf.datasource.removeAll()
                notificationsResponse.body.forEach {
                    strongSelf.datasource.append(TrendingProjectsCellModel(project: $0))
                }
                strongSelf.delegate?.didSetDatasource()
                completion?()
            case .failure(let error):
                strongSelf.delegate?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }

    private func item(at indexPath: IndexPath) -> TrendingProjectsCellModel {
        return datasource[indexPath.row]
    }
}
