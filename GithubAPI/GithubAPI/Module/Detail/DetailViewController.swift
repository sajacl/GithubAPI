//
//  DetailViewController.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-09.
//

import Foundation
import UIKit
import Common

final class DetailViewController: BaseViewController {
    private lazy var starCountView: RepositoryCounterView = {
        let parent = RepositoryCounterView(
            image: UIImage(systemName: "star.fill"),
            count: UInt(repository.stargazersCount)
        )
        parent.accessibilityLabel = "\(repository.stargazersCount) stars"
        parent.prepareForAutoLayout()
        return parent
    }()

    private lazy var forkCountView: RepositoryCounterView = {
        let parent = RepositoryCounterView(
            image: UIImage(systemName: "tuningfork"),
            count: UInt(repository.forksCount)
        )
        parent.accessibilityLabel = "\(repository.forksCount) forks"
        parent.prepareForAutoLayout()
        return parent
    }()

    private lazy var watchCountView: RepositoryCounterView = {
        let parent = RepositoryCounterView(
            image: UIImage(systemName: "eye.circle"),
            count: UInt(repository.watchersCount)
        )
        parent.accessibilityLabel = "\(repository.watchersCount) watchers"
        parent.prepareForAutoLayout()
        return parent
    }()

    private lazy var informationStackView: UIStackView = {
        let parent = UIStackView(arrangedSubviews: [
            starCountView,
            forkCountView,
            watchCountView
        ])

        parent.axis = .horizontal
        parent.distribution = .fillEqually

        parent.accessibilityLabel = "Repository information"
        parent.prepareForAutoLayout()
        return parent
    }()

    private lazy var descriptionLabel: UILabel = {
        let parent = UILabel()
        parent.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        parent.numberOfLines = 0
        parent.text = repository.description
        parent.accessibilityLabel = "Description"
        parent.prepareForAutoLayout()
        return parent
    }()

    private lazy var repositoryLinkLabel: UIButton = {
        let parent = UIButton(type: .system)
        parent.setTitle(openLinkText, for: .normal)
        parent.accessibilityLabel = "Github page link"
        parent.prepareForAutoLayout()
        return parent
    }()

    private let repository: RepositoryEntity

    init(repository: RepositoryEntity) {
        self.repository = repository

        super.init()
    }

    override func configViewController() {
        view.backgroundColor = UIColor.background

        title = repository.name
    }

    override func addViews() {
        view.addSubviews(
            informationStackView,
            descriptionLabel
        )
    }

    override func constraintViews() {
        informationStackView
            .topAnchor(equalTo: view.layoutMarginsGuide.topAnchor,
                       constant: UIMetrics.contentLayoutMargins.top)
            .leadingAnchor(equalTo: view.leadingAnchor,
                       constant: UIMetrics.contentLayoutMargins.right)
            .trailingAnchor(equalTo: view.trailingAnchor,
                       constant: -UIMetrics.contentLayoutMargins.left)
            .heightAnchor(constant: 40)

        descriptionLabel
            .topAnchor(equalTo: informationStackView.bottomAnchor, constant: 12)
            .leadingAnchor(equalTo: view.leadingAnchor,
                       constant: UIMetrics.contentLayoutMargins.right)
            .trailingAnchor(equalTo: view.trailingAnchor,
                       constant: -UIMetrics.contentLayoutMargins.left)
    }

    override func subscribeClicks() {
        guard URL(string: repository.htmlURL) != nil else {
            // no op
            return
        }

        view.addSubview(repositoryLinkLabel)

        repositoryLinkLabel
            .topAnchor(equalTo: descriptionLabel.bottomAnchor, constant: 12)
            .leadingAnchor(equalTo: view.leadingAnchor,
                       constant: UIMetrics.contentLayoutMargins.right)
            .trailingAnchor(equalTo: view.trailingAnchor,
                       constant: -UIMetrics.contentLayoutMargins.left)

        repositoryLinkLabel.addTarget(
            self,
            action: #selector(openLinkTapped),
            for: .touchUpInside
        )
    }

    @objc private func openLinkTapped(_ sender: UIButton) {
        guard let url = URL(string: repository.htmlURL) else {
            // no op
            return
        }

        if let navigationController = self.navigationController {
            navigationController.pushViewController(WebViewController(url: url), animated: true)
        } else {
            present(WebViewController(url: url), animated: true)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var openLinkText: String {
        NSLocalizedString(
            "REPOSITORY_LINK",
            tableName: "Detail",
            value: "Repository link",
            comment: ""
        )
    }
}
