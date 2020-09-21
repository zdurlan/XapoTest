//
//  OnboardingViewController.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 18/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

class OnboardingViewController: BaseLightStatusBarVC {
    // MARK: - Outlets
    @IBOutlet private var logoIcon: UIImageView!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var logoIconTopConstraint: NSLayoutConstraint!
    @IBOutlet private var logoIconCenterYConstraint: NSLayoutConstraint!
    @IBOutlet private var welcomeLabel: UILabel!
    @IBOutlet private var dummyTextLabel: UILabel!
    @IBOutlet private var termsTextView: UITextView! {
        didSet {
            termsTextView.delegate = self
        }
    }

    // MARK: - Properties
    var viewModel: OnboardingViewModel!

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods
    private func setupUI() {
        rotateLogo()
        setupPrivacyAndTerms()
        setupTexts()
    }

    private func rotateLogo() {
        UIView.animate(withDuration: AnimationConstants.transformDuration, animations: {
            self.logoIcon.transform = self.logoIcon.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { _ in
            UIView.animate(withDuration: AnimationConstants.transformDuration, animations: { () -> Void in
                self.logoIcon.transform = self.logoIcon.transform.rotated(by: CGFloat(Double.pi))
            }, completion: { _ in
                self.moveLogoAndShowElements()
            })
        })
    }

    private func setupTexts() {
        dummyTextLabel.text = viewModel.dummyText
        welcomeLabel.text = viewModel.welcomeText
    }

    private func setupPrivacyAndTerms() {
        termsTextView.attributedText = viewModel.setupAttributedStringPrivacyAndTerms()

        let linkTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            .underlineColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        termsTextView.linkTextAttributes = linkTextAttributes
        termsTextView.textAlignment = .center
    }

    private func moveLogoAndShowElements() {
        UIView.animate(withDuration: AnimationConstants.transformDuration) {
            self.logoIconTopConstraint.isActive = true
            self.logoIconCenterYConstraint.isActive = false
            self.view.layoutIfNeeded()
            self.containerView.alpha = 1
        }
    }

    // MARK: - Actions
    @IBAction private func didTapGoToXapo(_ sender: Any) {
        viewModel.didTapGoToXapo()
    }

    @IBAction private func didTapEnterApp(_ sender: Any) {
        viewModel.didTapEnterApp()
    }
}

extension OnboardingViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        view.endEditing(true)
    }
}
