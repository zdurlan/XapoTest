//
//  NibLoadableView.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class NibLoadbleView: UIView {
    private func loadFromNib() {
        let viewSubclass = type(of: self)
        let customView: UIView = viewSubclass.loadFromNib(owner: self)
        customView.frame = bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(customView)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }
}
