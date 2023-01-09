//
//  RepositoryCounterView.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-09.
//

import Foundation
import UIKit
import Common

final class RepositoryCounterView: BaseView {
    private lazy var countLabel: UILabel = {
        let parent = UILabel()
        parent.textColor = UIColor.text
        parent.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        parent.textAlignment = .right
        parent.prepareForAutoLayout()
        return parent
    }()

    private lazy var imageView: UIImageView = {
        let parent = UIImageView()
        parent.contentMode = .scaleAspectFit
        parent.prepareForAutoLayout()
        return parent
    }()

    init(image: UIImage?, count: UInt) {
        super.init(frame: .zero)

        imageView.image = image
        updateView(with: count)

        isAccessibilityElement = true
        imageView.isAccessibilityElement = false
        countLabel.isAccessibilityElement = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addViews() {
        addSubviews(
            countLabel,
            imageView
        )
    }

    override func constraintViews() {
        imageView
            .centerYAnchor(equalTo: centerYAnchor)
            .trailingAnchor(equalTo: trailingAnchor,
                       constant: -UIMetrics.contentLayoutMargins.right)
            .widthAnchor(constant: 25)
            .heightAnchor(constant: 25)

        countLabel
            .centerYAnchor(equalTo: centerYAnchor)
            .trailingAnchor(equalTo: imageView.leadingAnchor, constant: -18)
    }

    private func updateView(with count: UInt) {
        if count > 10 {
            imageView.tintColor = UIColor.red
        } else {
            imageView.tintColor = UIColor.yellow
        }

        countLabel.text = String(count)
    }
}
