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
    private let repository: RepositoryEntity

    private lazy var starCountView: UIView = {
        let parent = UIView()
        
        return parent
    }()

    private lazy var forkCountView: UIView = {
        let parent = UIView()

        return parent
    }()

    init(repository: RepositoryEntity) {
        self.repository = repository

        super.init()
    }

    override func configViewController() {
        view.backgroundColor = UIColor.background

        title = repository.name
    }

    override func addViews() {

    }

    override func constraintViews() {

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
