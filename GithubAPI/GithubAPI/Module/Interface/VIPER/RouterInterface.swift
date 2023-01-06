//
//  RouterInterface.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import UIKit

protocol RouterInterface: AnyObject {}

class BaseRouter<T> where T: UIViewController {
    private unowned var _viewController: T

    private var _temporaryStoredViewController: T?

    init(viewController: T) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    }
}

extension BaseRouter: RouterInterface {}

extension BaseRouter {
    var viewController: T {
        defer { _temporaryStoredViewController = nil }
        return _viewController
    }

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }

    func present(_ viewController: UIViewController, animated: Bool = true) {
        self.viewController.present(viewController, animated: animated)
    }

    func push(_ viewController: UIViewController, animated: Bool = true, disableTabbarSwipe: Bool = false) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
}

extension UIViewController {
    func presentWireframe(_ wireframe: BaseRouter<UIViewController>, animated: Bool = true, completion: (()->())? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    func pushWireframe(_ wireframe: BaseRouter<UIViewController>, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: BaseRouter<UIViewController>, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}
