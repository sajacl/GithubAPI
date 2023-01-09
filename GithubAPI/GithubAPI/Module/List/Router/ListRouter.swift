//
//  ListRouter.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import UIKit

final class ListRouter: BaseRouter<UIViewController>, ListRouterInterface {
    init() {
        let moduleViewController = ListViewController()

        super.init(viewController: moduleViewController)

        let interactor = ListInteractor()
        let presenter = ListPresenter(view: moduleViewController, interactor: interactor, router: self)
        moduleViewController.presenter = presenter
    }

    func navigateToDetail(with repository: RepositoryEntity) {
        lazy var detailViewController = DetailViewController(repository: repository)

        if let splitViewController = viewController.splitViewController {
            splitViewController.showDetailViewController(detailViewController, sender: viewController)
        } else {
            if let navigationController = navigationController {
                navigationController.pushViewController(detailViewController, animated: true)
            } else {
                present(detailViewController)
            }
        }
    }
}
