//
//  TransitioningAnimator.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 19/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

protocol TransitioningAnimator: UIViewControllerAnimatedTransitioning {
    var isDisplaying: Bool { get set }
}
