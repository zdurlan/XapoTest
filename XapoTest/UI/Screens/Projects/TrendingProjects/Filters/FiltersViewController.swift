//
//  FiltersViewController.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class FiltersViewController: BaseLightStatusBarVC {
    // MARK: - Outlet
    @IBOutlet private var timePeriodControl: UISegmentedControl!
    @IBOutlet private var languageControl: UISegmentedControl!
    @IBOutlet private var applyButton: UIButton! {
        didSet {
            setApplyButton(isActive: false)
        }
    }

    // MARK: - Properties
    var viewModel: FiltersViewModel!

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupFiltersDefaultValues()
    }

    // MARK: - Private
    private func setupNavigationBar() {
        addXapoNavigationBar(title: viewModel.title)
        if let xapoNavigationBar = xapoNavigationBar {
            xapoNavigationBar.textAlignment = .center

            let closeButton = UIBarButtonItem(xapoItem: .back, target: self, action: #selector(dismissFilters))
            xapoNavigationBar.setLeftBarButtons(buttons: [closeButton])
        }
    }

    private func setApplyButton(isActive: Bool) {
        applyButton.isUserInteractionEnabled = isActive
        applyButton.backgroundColor = isActive ? UIColor.Xapo.xapoBlue : UIColor.lightGray
    }

    private func setupFiltersDefaultValues() {
        var selectedIndex = 0
        switch viewModel.filters.timePeriod {
        case .daily:
            selectedIndex = 0
        case .weekly:
            selectedIndex = 1
        case .monthly:
            selectedIndex = 2
        }
        timePeriodControl.selectedSegmentIndex = selectedIndex

        switch viewModel.filters.language {
        case .all:
            selectedIndex = 0
        case .swift:
            selectedIndex = 1
        }
        languageControl.selectedSegmentIndex = selectedIndex
    }

    // MARK: - Actions
    @IBAction private func didChangePeriod(_ sender: UISegmentedControl) {
        setApplyButton(isActive: true)
        viewModel.changedPeriod(sender.selectedSegmentIndex)
    }

    @IBAction private func didChangeLanguage(_ sender: UISegmentedControl) {
        setApplyButton(isActive: true)
        viewModel.changedLanguage(sender.selectedSegmentIndex)
    }

    @IBAction private func didTapApply(_ sender: Any) {
        viewModel.applyFilters()
    }

    @objc private func dismissFilters() {
        viewModel.dismiss()
    }
}
