//
//  XapoNavigationBar.swift
//  XapoTest
//
//  Created by Alin Zdurlan on 20/09/2020.
//  Copyright © 2020 Alin Zdurlan. All rights reserved.
//

import UIKit

private struct NavigationBarConstants {
    static let buttonWidth: CGFloat = 48
    static let defaultTitleFontSize: CGFloat = 20
}

class XapoNavigationBar: NibLoadbleView {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var leftButtonsStack: UIStackView!
    @IBOutlet private var rightButtonsStack: UIStackView!
    @IBOutlet private var leftTitleConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleActionButton: UIButton! {
        didSet {
            titleActionButton.isUserInteractionEnabled = false
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var textAlignment: NSTextAlignment? {
        didSet {
            guard let textAlignment = textAlignment else {
                return
            }

            titleLabel.textAlignment = textAlignment
            leftTitleConstraint.isActive = textAlignment == .left
        }
    }

    static func navigationBar(with title: String?) -> XapoNavigationBar {
        let navBar: XapoNavigationBar = XapoNavigationBar(frame: .zero)
        navBar.setTitle(title: title, fontSize: NavigationBarConstants.defaultTitleFontSize)
        return navBar
    }

    // MARK: - Bar buttons utils
    func setLeftBarButtons(buttons: [UIBarButtonItem]) {
        removeLeftButtons()
        buttons.forEach { (buttonItem) in
            let button = createButton(with: buttonItem)
            leftButtonsStack.addArrangedSubview(button)
        }
        updateTextAlignment()
    }

    func setRightBarButtons(buttons: [UIBarButtonItem], noImage: Bool? = false, tintColor: UIColor? = nil) {
        removeRightButtons()
        buttons.forEach { (buttonItem) in
            let button = createButton(with: buttonItem, tintColor: tintColor)
            rightButtonsStack.addArrangedSubview(button)
        }
        updateTextAlignment()
    }

    func setupFilterButtonActive(_ isActive: Bool) {
        if let button = rightButtonsStack.arrangedSubviews.first {
            button.tintColor = isActive ? UIColor.Xapo.xapoSoftRed : .white
        }
    }

    func setButtonsEnabled(_ enabled: Bool) {
        setLeftButtonsEnabled(enabled)
        setRightButtonEnabled(enabled)
    }

    func setLeftButtonsEnabled(_ enabled: Bool) {
        setButtonsEnabled(enabled, stackView: leftButtonsStack)
    }

    func setLeftButtonsHidden(_ hidden: Bool) {
        setButtonsHidden(hidden, stackView: leftButtonsStack)
    }

    func setRightButtonEnabled(_ enabled: Bool, shouldBeFadedIfDisabled: Bool = true) {
        setButtonsEnabled(enabled, stackView: rightButtonsStack, shouldBeFadedIfDisabled: shouldBeFadedIfDisabled)
    }

    func setLeftButtonEnabled(_ enabled: Bool, shouldBeFadedIfDisabled: Bool = true) {
        setButtonsEnabled(enabled, stackView: leftButtonsStack, shouldBeFadedIfDisabled: shouldBeFadedIfDisabled)
    }

    func setTitleActionEnabled(_ enabled: Bool) {
        titleActionButton.isUserInteractionEnabled = enabled
    }

    func removeRightButtons() {
        rightButtonsStack.arrangedSubviews.forEach { (buttonItem) in
            buttonItem.removeFromSuperview()
            rightButtonsStack.removeArrangedSubview(buttonItem)
        }
        updateTextAlignment()
    }

    func removeLeftButtons() {
        leftButtonsStack.arrangedSubviews.forEach { (buttonItem) in
            buttonItem.removeFromSuperview()
            leftButtonsStack.removeArrangedSubview(buttonItem)
        }
        updateTextAlignment()
    }

    private func setButtonsEnabled(_ enabled: Bool, stackView: UIStackView, shouldBeFadedIfDisabled: Bool = true) {
        stackView.arrangedSubviews.forEach { (arrangedSubview) in
            if let aControl = arrangedSubview as? UIControl {
                if shouldBeFadedIfDisabled {
                    aControl.isEnabled = enabled
                } else {
                    aControl.isUserInteractionEnabled = enabled
                }
            } else {
                arrangedSubview.isUserInteractionEnabled = enabled
            }
        }
    }

    private func setButtonsHidden(_ hidden: Bool, stackView: UIStackView) {
        stackView.arrangedSubviews.forEach { (arrangedSubview) in
            arrangedSubview.isHidden = hidden
        }
    }

    // MARK: - Title utils
    var title: String? {
        return titleLabel.text
    }

    func setTitle(_ title: String? = nil, animated: Bool) {
        guard animated else {
            setTitle(title: title)
            return
        }

        UIView.transition(with: titleLabel, duration: AnimationConstants.navBarTitleAnimationDuration,
                          options: .transitionCrossDissolve, animations: { [weak self] in
            self?.setTitle(title: title)
        }, completion: nil)
    }

    func setTitleFont(_ font: UIFont) {
        UIView.transition(with: titleLabel, duration: AnimationConstants.navBarTitleAnimationDuration,
                          options: .transitionCrossDissolve, animations: { [weak self] in
                            self?.titleLabel.font = font
        }, completion: nil)
    }

    func updateTextAlignment() {
        guard textAlignment == nil else {
            return
        }

        if !leftButtonsStack.arrangedSubviews.isEmpty || !rightButtonsStack.arrangedSubviews.isEmpty {
            titleLabel.textAlignment = .center
        } else {
            titleLabel.textAlignment = .left
        }
    }

    func setTitleLeftOffset(_ offset: CGFloat) {
        leftTitleConstraint.constant = offset
        setNeedsLayout()
    }

    // MARK: - Private

    private func createButton(with buttonItem: UIBarButtonItem, tintColor: UIColor? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.tintColor = tintColor ?? UIColor.white

        if let image = buttonItem.image {
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }

        if let target = buttonItem.target, let action = buttonItem.action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }

        button.setWidthConstraint(widthConstant: NavigationBarConstants.buttonWidth)

        if let title = buttonItem.title {
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            button.setWidthConstraint(widthConstant: button.titleLabel?.intrinsicContentSize.width ?? 0)
        }

        return button
    }

    private func setTitle(title: String? = nil, fontSize: CGFloat = NavigationBarConstants.defaultTitleFontSize) {
        if title != nil {
            titleLabel.text = title
            titleLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
    }
}

// MARK: - UIBarButtonItem
extension UIBarButtonItem {
    enum XapoBarItem {
        case back
        case filter
        case filterApplied
    }

    static func xapoIcon(for item: XapoBarItem) -> UIImage? {
        var imageName: String?

        switch item {
        case .back:
            imageName = "backButtonIcon"
        case .filter:
            imageName = "filterIcon"
        case .filterApplied:
            imageName = "filterIconApplied"
        }

        guard imageName != nil else {
            return nil
        }

        return UIImage(named: imageName!)
    }

    convenience init(xapoItem: XapoBarItem, target: Any?, action: Selector?) {
        let image = UIBarButtonItem.xapoIcon(for: xapoItem)
        self.init(image: image, style: .plain, target: target, action: action)
    }
}
