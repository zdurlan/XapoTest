//
//  TrendingProjectsTableViewCell.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class TrendingProjectsTableViewCell: BaseTableViewCell {
    // MARK: - Outlets
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var colorView: UIView!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var starsLabel: UILabel!
    @IBOutlet private var forksLabel: UILabel!

    // MARK: - Properties
    var viewModel: TrendingProjectsCellModel! {
        didSet {
            setupCell(name: viewModel.name, color: viewModel.color,
                      language: viewModel.language, stars: viewModel.stars,
                      forks: viewModel.forks)
        }
    }

    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Private
    private func setupCell(name: String, color: String, language: String, stars: Int, forks: Int) {
        nameLabel.text = name
        colorView.backgroundColor = UIColor(hexString: color)
        languageLabel.text = language
        starsLabel.text = "\(stars)"
        forksLabel.text = "\(forks)"
    }
}
