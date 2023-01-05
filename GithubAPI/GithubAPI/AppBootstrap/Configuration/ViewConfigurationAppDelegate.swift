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
        window?.rootViewController = Self.createRootViewController()
        window?.makeKeyAndVisible()

        return true
    }

    private static func createRootViewController() -> UIViewController {
        ViewController()
    }
}
