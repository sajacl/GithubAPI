//
//  CustomNavigationBar.swift
//  
//
//  Created by Sajad Vishkai on 2023-01-09.
//

import Foundation
import UIKit

final public class CustomNavigationBar: UINavigationBar {
    private static let titleTextAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white,
    ]

    private static let backButtonTitlePositionOffset = UIOffset(horizontal: 4, vertical: 0)
    private static let backButtonTitleTextAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white,
    ]

    private let customBackIndicatorImage = UIImage(systemName: "arrowshape.backward.fill")?
        .withTintColor(
            UIColor.white,
            renderingMode: .alwaysOriginal
        )

    private let customBackIndicatorTransitionMask = UIImage(named: "IconBackTransitionMask")

    // Returns the distance from the title label to the bottom of navigation bar
    public var titleLabelBottomInset: CGFloat {
        // Go two levels deep only
        let subviewsToExamine = subviews.flatMap { view -> [UIView] in
            return [view] + view.subviews
        }

        let titleLabel = subviewsToExamine.first { view -> Bool in
            return view is UILabel
        }

        if let titleLabel = titleLabel {
            let titleFrame = titleLabel.convert(titleLabel.bounds, to: self)
            return max(bounds.maxY - titleFrame.maxY, 0)
        } else {
            return 0
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        var margins = layoutMargins
        margins.left = 24
        margins.right = 24
        layoutMargins = margins

        setupNavigationBarAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNavigationBarAppearance() {
        tintColor = UIColor.white
        backgroundColor = UIColor.white
        isTranslucent = false

        standardAppearance = makeNavigationBarAppearance()
        scrollEdgeAppearance = makeNavigationBarAppearance()
    }

    private func makeNavigationBarAppearance() -> UINavigationBarAppearance {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = Self.titleTextAttributes
        navigationBarAppearance.largeTitleTextAttributes = Self.titleTextAttributes

        let plainBarButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        plainBarButtonAppearance.normal.titleTextAttributes = Self.titleTextAttributes

        let doneBarButtonAppearance = UIBarButtonItemAppearance(style: .done)
        doneBarButtonAppearance.normal.titleTextAttributes = Self.titleTextAttributes

        let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        backButtonAppearance.normal.titlePositionAdjustment = Self.backButtonTitlePositionOffset
        backButtonAppearance.normal.titleTextAttributes = Self.backButtonTitleTextAttributes

        navigationBarAppearance.buttonAppearance = plainBarButtonAppearance
        navigationBarAppearance.doneButtonAppearance = doneBarButtonAppearance
        navigationBarAppearance.backButtonAppearance = backButtonAppearance

        if #available(iOS 14, *) {
            navigationBarAppearance.setBackIndicatorImage(
                customBackIndicatorImage,
                transitionMaskImage: customBackIndicatorTransitionMask
            )
        } else {
            // Bug: on iOS 13 setBackIndicatorImage accepts parameters in backward order
            // https://stackoverflow.com/a/58171229/351305
            navigationBarAppearance.setBackIndicatorImage(
                customBackIndicatorTransitionMask,
                transitionMaskImage: customBackIndicatorImage
            )
        }

        return navigationBarAppearance
    }
}

