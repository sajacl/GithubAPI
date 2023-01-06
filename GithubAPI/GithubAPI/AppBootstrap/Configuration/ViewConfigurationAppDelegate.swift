//
//  ViewConfigurationAppDelegate.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-05.
//

import Foundation
import UIKit

class ViewConfigurationAppDelegate: AppDelegateType {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = createRootViewController(for: UIDevice.current.userInterfaceIdiom)
        window?.makeKeyAndVisible()

        return true
    }

    private func createRootViewController(
        for userInterface: UIUserInterfaceIdiom
    ) -> UIViewController {
        if userInterface == .pad {
            return ViewController()
        }

        return ViewController()
    }
}
