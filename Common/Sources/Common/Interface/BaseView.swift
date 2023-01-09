//
//  BaseView.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import UIKit

open class BaseView: UIView, ViewInterface {
    public override init(frame: CGRect) {
        super.init(frame: frame)

        configViewController()
        addViews()
        constraintViews()
        subscribeClicks()
    }

    public required init?(coder: NSCoder) {
        fatalError("MVP does not support storyboard initializations.")
    }

    open func configViewController() {}
    open func addViews() {}
    open func constraintViews() {}
    open func subscribeClicks() {}
}
