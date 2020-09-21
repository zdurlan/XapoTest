//
//  TrendingProjectsViewController.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import SkeletonView
import UIKit

class TrendingProjectsViewController: BaseLightStatusBarVC {
    // MARK: - Outlets
    @IBOutlet private var tableView: UITableView!

    // MARK: - Properties
    var viewModel: TrendingProjectsViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        loadProjects()
    }

    // MARK: - Private
    private func setupNavigationBar() {
        addXapoNavigationBar(title: viewModel.title)
        if let xapoNavigationBar = xapoNavigationBar {
            xapoNavigationBar.textAlignment = .center

            let closeButton = UIBarButtonItem(xapoItem: .back, target: self, action: #selector(dismissTrendingProjects))
            xapoNavigationBar.setLeftBarButtons(buttons: [closeButton])

            let filterButton = UIBarButtonItem(xapoItem: .filter, target: self,
                                               action: #selector(filterTrendingProjects))
            xapoNavigationBar.setRightBarButtons(buttons: [filterButton])
            xapoNavigationBar.setupFilterButtonActive(viewModel.hasFilters())

        }
    }

    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60.0
        TrendingProjectsTableViewCell.register(to: tableView)
    }

    private func loadProjects() {
        viewModel.loadDataSource()
    }

    // MARK: - Actions
    @objc private func dismissTrendingProjects() {
        viewModel.dismiss()
    }

    @objc private func filterTrendingProjects() {
        viewModel.showFilters()
    }
}

extension TrendingProjectsViewController: UITableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    func collectionSkeletonView(_ skeletonView: UITableView,
                                cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        TrendingProjectsTableViewCell.identifier
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.cell(for: tableView, at: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

extension TrendingProjectsViewController: TrendingProjectsViewModelProtocol {
    func showActivityIndicator(shouldShow: Bool) {
        shouldShow ? showActivityIndicator() : hideActivityIndicator()
    }

    func showAlert(title: String, message: String) {
        presentAlertController(title: title, message: message)
    }

    func didSetDatasource() {
        DispatchQueue.main.async {
            self.tableView.reloadData()

            if let xapoNavigationBar = self.xapoNavigationBar {
                xapoNavigationBar.setupFilterButtonActive(self.viewModel.hasFilters())
            }
        }
    }
}
