//
//  LoadingView.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-09.
//

import Foundation
import UIKit
import Common

final class LoadingView: BaseView {
    private lazy var titleLabel: UILabel = {
        let parent = UILabel()
        parent.text = titleLabelText
        parent.accessibilityLabel = titleAccessibilityLabel
        parent.textColor = .darkGray
        parent.textAlignment = .center
        parent.prepareForAutoLayout()
        return parent
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let parent = UIActivityIndicatorView(style: .large)
        parent.tintColor = .black
        parent.hidesWhenStopped = false
        parent.prepareForAutoLayout()
        return parent
    }()

    override var isHidden: Bool {
        didSet {
            isHidden ? activityIndicator.startAnimating(): activityIndicator.stopAnimating()
        }
    }

    override func configViewController() {
        activityIndicator.startAnimating()
    }

    override func addViews() {
        self.addSubviews(
            titleLabel,
            activityIndicator
        )
    }

    override func constraintViews() {
        titleLabel
            .centerXAnchor(equalTo: self.centerXAnchor)
            .centerYAnchor(equalTo: self.centerYAnchor)
            .leadingAnchor(equalTo: self.leadingAnchor)
            .trailingAnchor(equalTo: self.trailingAnchor)

        activityIndicator
            .centerXAnchor(equalTo: self.centerXAnchor)
            .bottomAnchor(equalTo: titleLabel.topAnchor, constant: -20)
    }

    private var titleLabelText: String {
        NSLocalizedString(
            "LOADING_TITLE",
            tableName: "List",
            value: "Loading",
            comment: ""
        )
    }

    private var titleAccessibilityLabel: String {
        NSLocalizedString(
            "LOADING_ACCESSIBILITY",
            tableName: "List",
            value: "Loading repositories",
            comment: ""
        )
    }
}
