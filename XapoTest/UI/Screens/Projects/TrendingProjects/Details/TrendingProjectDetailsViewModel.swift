//
//  TrendingProjectDetailsViewModel.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import Kingfisher
import UIKit

protocol ProjectDetailsViewModelNavigationProtocol: class {
    func dismiss()
}

class ProjectsDetailsViewModel {
    // MARK: - Properties
    private let project: TrendingProject

    weak var navigationDelegate: ProjectDetailsViewModelNavigationProtocol?

    var title: String {
        return project.name
    }

    var color: String {
        return project.languageColor
    }

    var language: String {
        return project.language
    }

    var stars: Int {
        return project.stars
    }

    var forks: Int {
        return project.forks
    }

    var url: String {
        return project.url
    }

    var description: String {
        return project.description
    }

    var avatarUrl: String {
        return project.avatar
    }

    var author: String {
        return project.author
    }

    var builtBy: [GithubUser] {
        return project.builtBy
    }

    // MARK: - Init
    init(project: TrendingProject) {
        self.project = project
    }

    // MARK: - Methods
    func setupAttributedStringURL() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: url)

        let range = attributedString.mutableString.range(of: attributedString.mutableString as String)
        attributedString.addAttribute(NSAttributedString.Key.link, value: url, range: range)

        let fontAndColorAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        attributedString.addAttributes(fontAndColorAttributes,
                                       range: range)
        return attributedString
    }

    func setAvatarImage(on imageView: UIImageView, completion: @escaping (() -> Void)) {
        let url = URL(string: avatarUrl)
        imageView.kf.setImage(with: url) { _ in
            completion()
        }
    }

    func dismiss() {
        navigationDelegate?.dismiss()
    }

    // MARK: - CollectionView
    func numberOfItems() -> Int {
        return builtBy.count
    }

    func cell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = ProjectDetailsContributorsCell.identifier
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? ProjectDetailsContributorsCell else {
            assertionFailure("cell should be available")
            return UICollectionViewCell()
        }

        cell.viewModel = cellModel(at: indexPath)
        return cell
    }

    // MARK: - Private
    private func cellModel(at index: IndexPath) -> DetailsContributorsCellModel {
        let contributor = builtBy[index.row]
        return DetailsContributorsCellModel(imageURL: contributor.avatar)
    }
}
