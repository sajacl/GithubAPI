//
//  CustomSplitViewController.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-09.
//

import Foundation
import UIKit

final public class CustomSplitViewController: UISplitViewController {
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    public var pendingRoute: UIViewController?

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let pendingRoute = pendingRoute {
            self.present(pendingRoute, animated: true)
        }
    }
}
