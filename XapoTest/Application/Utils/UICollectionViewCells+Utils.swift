//
//  UICollectionViewCells+Utils.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 21/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }

    static func register(to collectionView: UICollectionView) {
        let nibFile = UINib(nibName: identifier, bundle: nil)
        collectionView.register(nibFile, forCellWithReuseIdentifier: identifier)
    }
}
