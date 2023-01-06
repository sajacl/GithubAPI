//
//  ListPresenter.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation

final class ListPresenter: ListPresenterInterface {
    private weak var view: ListViewInterface?
    private let interactor: ListInteractorInterface
    private let router: ListRouterInterface

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
}
