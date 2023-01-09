//
//  BaseViewController.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController, ViewInterface {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("MVP does not support storyboard initializations.")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        configViewController()
        addViews()
        constraintViews()
        subscribeClicks()
    }

    open func configViewController() {}
    open func addViews() {}
    open func constraintViews() {}
    open func subscribeClicks() {}
}
