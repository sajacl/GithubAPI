//
//  RepositoryTableViewCell.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-08.
//

import Foundation
import UIKit
import Common

final class RepositoryTableViewCell: UITableViewCell {
    private lazy var repositoryNameLabel: UILabel = {
        let parent = UILabel()
        parent.textColor = .darkGray
        parent.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        parent.prepareForAutoLayout()
        return parent
    }()

    private lazy var repositoryStarCountLabel: UILabel = {
        let parent = UILabel()
        parent.textColor = .darkGray
        parent.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        parent.prepareForAutoLayout()
        return parent
    }()

    private lazy var startImageView: UIImageView = {
        let parent = UIImageView()
        parent.contentMode = .scaleAspectFit
        parent.image = UIImage(systemName: "star.fill")
        parent.tintColor = .yellow
        parent.prepareForAutoLayout()
        return parent
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configCell()
        addViews()
        constraintViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configCell() {
        selectionStyle = .none
        contentView.backgroundColor = .white
    }

    private func addViews() {
        contentView.addSubviews(
            repositoryNameLabel,
            repositoryStarCountLabel,
            startImageView
        )
    }

    private func constraintViews() {
        startImageView
            .centerYAnchor(equalTo: contentView.centerYAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor,
                       constant: -UIMetrics.contentLayoutMargins.right)
            .widthAnchor(constant: 25)
            .heightAnchor(constant: 25)

        repositoryStarCountLabel
            .centerYAnchor(equalTo: contentView.centerYAnchor)
            .trailingAnchor(equalTo: startImageView.leadingAnchor, constant: -18)
            .setContentHuggingPriority(.defaultHigh, for: .horizontal)

        repositoryNameLabel
            .centerYAnchor(equalTo: contentView.centerYAnchor)
            .leadingAnchor(equalTo: contentView.leadingAnchor,
                       constant: UIMetrics.contentLayoutMargins.left)
            .trailingAnchor(equalTo: repositoryStarCountLabel.safeAreaLayoutGuide.leadingAnchor)
            .setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    func updateView(with model: RepositoryEntity) {
        repositoryNameLabel.text = model.name

        let starCount = model.stargazersCount

        if starCount > 10 {
            startImageView.tintColor = .red
        } else {
            startImageView.tintColor = .yellow
        }

        repositoryStarCountLabel.text = String(starCount)
    }

    override func prepareForReuse() {
        startImageView.tintColor = .yellow
    }
}