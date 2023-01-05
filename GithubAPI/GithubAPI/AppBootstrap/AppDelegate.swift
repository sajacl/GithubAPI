//
//  AppDelegate.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-05.
//

import UIKit

typealias AppDelegateType = UIResponder & UIApplicationDelegate

@main
class AppDelegate: AppDelegateType {
    private let appDelegate = AppDelegateFactory.default()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if let didFinish = appDelegate.application?(application, didFinishLaunchingWithOptions: launchOptions) {
            return didFinish
        }

        preconditionFailure(
            "One or many application configuration(s) was failed to finishing launch sequence."
        )
    }
}
