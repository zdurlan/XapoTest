//
//  ProjectDetailsContributorsCell.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 21/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class ProjectDetailsContributorsCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet private var contributorsImage: UIImageView! {
        didSet {
            contributorsImage.showGradientSkeleton()
        }
    }

    // MARK: - Properties
    var viewModel: DetailsContributorsCellModel! {
        didSet {
            viewModel.setContributorImage(on: contributorsImage) { [weak self] in
                self?.contributorsImage.hideSkeleton()
            }
        }
    }

    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
