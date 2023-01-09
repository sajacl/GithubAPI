//
//  CustomSplitViewController.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-09.
//

import Foundation
import UIKit

final class CustomSplitViewController: UISplitViewController {
    var pendingRoute: UIViewController?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let pendingRoute = pendingRoute {
            self.present(pendingRoute, animated: true)
        }
    }
}
