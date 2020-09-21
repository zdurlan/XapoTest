//
//  ProjectDetailsContributorsCellModel.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 21/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class DetailsContributorsCellModel {
    // MARK: - Properties
    private let imageURL: String

    var contributorImage: UIImage?

    // MARK: - Init
    init(imageURL: String) {
        self.imageURL = imageURL
    }

    func setContributorImage(on imageView: UIImageView, completion: @escaping (() -> Void)) {
        let url = URL(string: imageURL)
        imageView.kf.setImage(with: url) { _ in
            completion()
        }
    }
}
