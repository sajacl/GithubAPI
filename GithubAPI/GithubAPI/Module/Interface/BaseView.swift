//
//  BaseView.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import UIKit

class BaseView: UIView, ViewInterface {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configViewController()
        addViews()
        constraintViews()
        subscribeClicks()
    }

    required init?(coder: NSCoder) {
        fatalError("MVP does not support storyboard initializations.")
    }

    func configViewController() {}
    func addViews() {}
    func constraintViews() {}
    func subscribeClicks() {}
}
