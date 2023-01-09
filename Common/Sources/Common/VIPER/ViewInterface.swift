//
//  ViewInterface.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation

public protocol ViewInterface: AnyObject {
    func configViewController()
    func addViews()
    func constraintViews()
    func subscribeClicks()

    func showLoading()
    func hideLoading()
}

public extension ViewInterface {
    func showLoading() {}

    func hideLoading() {}
}
