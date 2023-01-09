//
//  RouterInterface.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import UIKit

public protocol RouterInterface: AnyObject {}

open class BaseRouter<T>: RouterInterface where T: UIViewController {
    private unowned var _viewController: T

    private var _temporaryStoredViewController: T?

    public init(viewController: T) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    }
}

extension BaseRouter {
    public var viewController: T {
        defer { _temporaryStoredViewController = nil }
        return _viewController
    }

    public var navigationController: UINavigationController? {
        return viewController.navigationController
    }

    public func present(_ viewController: UIViewController, animated: Bool = true) {
        self.viewController.present(viewController, animated: animated)
    }

    public func push(_ viewController: UIViewController, animated: Bool = true, disableTabbarSwipe: Bool = false) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
}

extension UIViewController {
    public func presentWireframe(_ wireframe: BaseRouter<UIViewController>, animated: Bool = true, completion: (()->())? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    public func pushWireframe(_ wireframe: BaseRouter<UIViewController>, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    public func setRootWireframe(_ wireframe: BaseRouter<UIViewController>, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}
