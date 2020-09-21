//
//  TrendingProjectDetailsViewController.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class TrendingProjectDetailsVC: BaseLightStatusBarVC {
    // MARK: - Outlets
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var authorImageView: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var forksLabel: UILabel!
    @IBOutlet private var starsLabel: UILabel!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var languageColorView: UIView!
    @IBOutlet private var contributorsCollectionView: UICollectionView!
    @IBOutlet private var urlTextView: UITextView! {
        didSet {
            urlTextView.delegate = self
        }
    }

    // MARK: - Properties
    var viewModel: ProjectsDetailsViewModel!

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        authorImageView.showAnimatedGradientSkeleton()
        setupNavigationBar()
        setupLayout()
        setupContributorsCollectionView()
    }

    // MARK: - Privtte
    private func setupNavigationBar() {
        addXapoNavigationBar(title: viewModel.title)
        if let xapoNavigationBar = xapoNavigationBar {
            xapoNavigationBar.textAlignment = .center

            let closeButton = UIBarButtonItem(xapoItem: .back, target: self, action: #selector(dismissDetails))
            xapoNavigationBar.setLeftBarButtons(buttons: [closeButton])
        }
    }

    private func setupLayout() {
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.description
        forksLabel.text = "\(viewModel.forks)"
        starsLabel.text = "\(viewModel.stars)"
        languageLabel.text = viewModel.language
        languageColorView.backgroundColor = UIColor(hexString: viewModel.color)
        viewModel.setAvatarImage(on: authorImageView) { [weak self] in
            self?.authorImageView.hideSkeleton()
        }
        setupURL()
    }

    private func setupURL() {
        urlTextView.attributedText = viewModel.setupAttributedStringURL()

        let linkTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.Xapo.xapoBlue
        ]
        urlTextView.linkTextAttributes = linkTextAttributes
        urlTextView.textAlignment = .left
    }

    private func setupContributorsCollectionView() {
        ProjectDetailsContributorsCell.register(to: contributorsCollectionView)
    }

    // MARK: - Actions
    @objc private func dismissDetails() {
        viewModel.dismiss()
    }
}

extension TrendingProjectDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.cell(for: collectionView, at: indexPath)
    }
}

extension TrendingProjectDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 50, height: 50)
    }
}

extension TrendingProjectDetailsVC: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        view.endEditing(true)
    }
}
