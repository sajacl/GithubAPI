//
//  CustomNavigationController.swift
//  
//
//  Created by Sajad Vishkai on 2023-01-09.
//

import Foundation
import UIKit

final public class CustomNavigationController: UINavigationController {
    public override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }

    public override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }

    override public init(rootViewController: UIViewController) {
        super.init(navigationBarClass: CustomNavigationBar.self, toolbarClass: nil)

        viewControllers = [rootViewController]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
