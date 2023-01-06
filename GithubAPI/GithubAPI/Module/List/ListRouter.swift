//
//  ListRouter.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation

final class ListRouter: BaseRouter<ListViewController>, ListRouterInterface {
    init() {
        let moduleViewController = ListViewController()
        moduleViewController.view.backgroundColor = .white
        super.init(viewController: moduleViewController)

        let interactor = ListInteractor()
        let presenter = ListPresenter(view: moduleViewController, interactor: interactor, router: self)
        moduleViewController.presenter = presenter
    }
}
