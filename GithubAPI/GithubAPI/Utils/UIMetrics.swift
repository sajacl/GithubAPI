//
//  UIMetrics.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-09.
//

import Foundation
import UIKit

enum UIMetrics {
    /// Common layout margins for content presentation
    static let contentLayoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)

    /// Minimum sidebar width in points
    static let minimumSplitViewSidebarWidth: CGFloat = 300

    /// Maximum sidebar width in percentage points (0...1)
    static let maximumSplitViewSidebarWidthFraction: CGFloat = 0.3

    /// Layout size for Github login prompt in iPad.
    static let preferredLoginModalSize: CGSize = CGSize(width: 350, height: 650)
}
