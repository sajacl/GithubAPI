//
//  ViewConfigurationAppDelegate.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-05.
//

import Foundation
import UIKit
import Common

class ViewConfigurationAppDelegate: AppDelegateType {
    var window: UIWindow?

    /// Credentials for Github login sequence.
    /// To prevent them from hardcoding, they have been added to environment.
    private lazy var credentials = LoginCredentials(
        clientId: ProcessInfo.processInfo.environment["client_id"]!,
        clientSecret: ProcessInfo.processInfo.environment["client_secret"]!,
        redirectURL: ProcessInfo.processInfo.environment["client_callback"]!
    )

    /// Flag to determine user is logged in and we have access to their token.
    private var isLoggedIn: Bool {
        (try? KeychainManager.readToken()) != nil
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = createRootViewController()
        window?.makeKeyAndVisible()

        return true
    }

    private func createRootViewController() -> UIViewController {
        let userInterface = UIDevice.current.userInterfaceIdiom

        if isLoggedIn {
            return createRepositoryListViewController(for: userInterface)
        }

        return createLoginViewController(for: userInterface)
    }

    private func createRepositoryListViewController(
        for userInterface: UIUserInterfaceIdiom
    ) -> UIViewController {
        if userInterface == .pad {
            return createPadSplitViewController()
        }

        return createListViewController()
    }

    private func createLoginViewController(
        for userInterface: UIUserInterfaceIdiom
    ) -> UIViewController {
        lazy var loginViewController = LoginViewController(credentials: credentials)

        if userInterface == .pad {
            let splitViewController = createPadSplitViewController()

            loginViewController.modalPresentationStyle = .formSheet
            loginViewController.preferredContentSize = UIMetrics.preferredLoginModalSize
            loginViewController.isModalInPresentation = true

            splitViewController.pendingRoute = loginViewController
            return splitViewController
        }

        return CustomNavigationController(
            rootViewController: loginViewController
        )
    }

    private func createPadSplitViewController() -> CustomSplitViewController {
        let listViewController = createListViewController()
        let detailViewController = CustomNavigationController(
            rootViewController: IPadDefaultViewController()
        )

        let splitViewController = CustomSplitViewController()
        splitViewController.preferredDisplayMode = .oneBesideSecondary
        splitViewController.minimumPrimaryColumnWidth = UIMetrics.minimumSplitViewSidebarWidth
        splitViewController.preferredPrimaryColumnWidthFraction = UIMetrics.maximumSplitViewSidebarWidthFraction
        splitViewController.primaryEdge = .trailing
        splitViewController.viewControllers = [listViewController, detailViewController]
        return splitViewController
    }

    private func createListViewController() -> UIViewController {
        return CustomNavigationController(
            rootViewController: ListRouter().viewController
        )
    }
}
