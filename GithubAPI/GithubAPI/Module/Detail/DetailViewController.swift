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

//    private lazy var 

    init(repository: RepositoryEntity) {
        self.repository = repository

        super.init()
    }

    override func configViewController() {
        view.backgroundColor = .white

        title = repository.name


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
