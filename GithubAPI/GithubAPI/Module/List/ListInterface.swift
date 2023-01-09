//
//  ListInterface.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import Operations

protocol ListRouterInterface: RouterInterface {
    func navigateToDetail(with repository: RepositoryEntity) 
}

protocol ListViewInterface: ViewInterface {
    func repositoriesReceived(_ repositories: [RepositoryEntity])
    func fetchRepositoriesFailed(with error: String)
}

protocol ListPresenterInterface: PresenterInterface {
    func fetchRepositories(for owner: String)
    func repositorySelected(_ repository: RepositoryEntity)
}

protocol ListInteractorInterface: InteractorInterface {
    func fetchList(
        for owner: String,
        _ completion: @escaping ResultOperation<[RepositoryDecodableModel], Error>.CompletionHandler
    )
}
