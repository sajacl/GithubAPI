//
//  ListPresenter.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import OSLog

final class ListPresenter: ListPresenterInterface {
    private weak var view: ListViewInterface?
    private let interactor: ListInteractorInterface
    private let router: ListRouterInterface

    private let logger = Logger.list
    // MARK: - Lifecycle

    init(
        view: ListViewInterface,
        interactor: ListInteractorInterface,
        router: ListRouterInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func fetchRepositories(for owner: String) {
        interactor.fetchList(for: owner) { [weak self] result in
            guard let self = self else {
                // no op
                return
            }

            dispatchPrecondition(condition: .onQueue(.main))

            switch result {
            case let .success(repositories):
                self.view?.repositoriesReceived(
                    self.repositoryMapper(repositories)
                )

            case let .failure(error):
                self.logger.error(
                    "Fetching repositories failed. original error: \(error.localizedDescription)"
                )
                
                self.view?.fetchRepositoriesFailed(with: error.localizedDescription)

            case .cancelled: break
            }
        }
    }

    func repositorySelected(_ repository: RepositoryEntity) {
        router.navigateToDetail(with: repository)
    }

    private func repositoryMapper(_ repositories: [RepositoryDecodableModel]) -> [RepositoryEntity] {
        repositories.map(RepositoryEntity.init(from:))
    }
}
