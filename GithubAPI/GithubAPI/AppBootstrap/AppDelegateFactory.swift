//
//  AppDelegateFactory.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-05.
//

import Foundation
import UIKit

enum AppDelegateFactory {
    static func `default`() -> AppDelegateType {
        return CompositeAppDelegate(appDelegates: [
            ViewConfigurationAppDelegate()
        ])
    }
}
