//
//  BaseViewController.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, ViewInterface {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("MVP does not support storyboard initializations.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configViewController()
        addViews()
        constraintViews()
        subscribeClicks()
    }

    func configViewController() {}
    func addViews() {}
    func constraintViews() {}
    func subscribeClicks() {}
}
